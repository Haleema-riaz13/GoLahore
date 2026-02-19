import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';
import 'login_screen.dart';
import 'route_result_screen.dart';
import 'community_report_screen.dart';
import 'saved_routes_screen.dart';
import 'travel_history_screen.dart';
import 'safety_mode_screen.dart';
import 'help_support_screen.dart';

class SearchRoutesScreen extends StatefulWidget {
  final String language;

  const SearchRoutesScreen({super.key, this.language = "English"});

  @override
  State<SearchRoutesScreen> createState() => _SearchRoutesScreenState();
}

class _SearchRoutesScreenState extends State<SearchRoutesScreen> {
  // Global key for Scaffold to control Drawer and SnackBars
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  // Controller for handling map zoom and pan
  late TransformationController _transformationController;

  // Initial UI states
  String selectedFilter = "Public";
  bool isRouteSaved = false;
  bool isDarkMode = true;

  late String displaySearchText;
  late String rainAdvisoryText;

  // Controllers for various input fields
  final TextEditingController _sourceController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _reportNoteController = TextEditingController();

  // Profile management controllers
  final TextEditingController _nameController = TextEditingController(text: "User Name");
  final TextEditingController _emailController = TextEditingController(text: "user@lahoretransit.com");
  final TextEditingController _passController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _refreshLanguageText();
  }

  /// Updates the UI strings based on the selected language
  void _refreshLanguageText() {
    if (widget.language == "Urdu") {
      displaySearchText = "روانگی ← منزل تلاش کریں";
      rainAdvisoryText = "آج بارش ہے - ٹرانسپورٹ روٹ پلان کے مطابق ہے";
    } else if (widget.language == "Roman Urdu") {
      displaySearchText = "Search Source → Destination";
      rainAdvisoryText = "Aaj barish hai - transport route plan ke mutabiq hai";
    } else {
      displaySearchText = "Search Source → Destination";
      rainAdvisoryText = "Rain Today - transport suggested according to route plan";
    }
  }

  @override
  void dispose() {
    // Clean up controllers to avoid memory leaks
    _transformationController.dispose();
    _sourceController.dispose();
    _destinationController.dispose();
    _reportNoteController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passController.dispose();
    super.dispose();
  }

  // Dynamic color getters based on theme mode
  Color get _barColor => isDarkMode ? const Color(0xFF1A1A1A) : Colors.white;
  Color get _drawerColor => isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
  Color get _dynamicTextColor => isDarkMode ? Colors.white : Colors.black;
  Color get _dynamicIconColor => isDarkMode ? Colors.white70 : Colors.black87;

  /// Shows a confirmation dialog before logging out
  void _showLogoutConfirmation() {
    String logTitle = widget.language == "Urdu" ? "لاگ آؤٹ" : (widget.language == "Roman Urdu" ? "Logout Karein" : "Logout");
    String logMsg = widget.language == "Urdu" ? "کیا آپ واقعی لاگ آؤٹ کرنا چاہتے ہیں؟" : (widget.language == "Roman Urdu" ? "Kya aap logout karna chahte hain?" : "Are you sure you want to logout?");
    String cancel = widget.language == "Urdu" ? "منسوخ" : (widget.language == "Roman Urdu" ? "Nahi" : "Cancel");
    String confirm = widget.language == "Urdu" ? "جی ہاں" : (widget.language == "Roman Urdu" ? "Haan, Logout" : "Yes, Logout");

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _drawerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(logTitle, style: TextStyle(color: _dynamicTextColor, fontWeight: FontWeight.bold)),
        content: Text(logMsg, style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54)),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(cancel, style: TextStyle(color: isDarkMode ? Colors.white54 : Colors.black54))),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            onPressed: () {
              Navigator.pop(context);
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen(language: widget.language)), (route) => false);
            },
            child: Text(confirm, style: const TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  /// Placeholder dialog for upcoming offline map feature
  void _showOfflineComingSoon() {
    String title = widget.language == "Urdu" ? "جلد آ رہا ہے!" : (widget.language == "Roman Urdu" ? "Jald aa raha hai!" : "Coming Soon!");
    String msg = widget.language == "Urdu" ? "آف لائن میپس ابھی زیرِ تعمیر ہے! 🚀" : (widget.language == "Roman Urdu" ? "Offline maps jald launch hoga! 🚀" : "Offline Maps feature is under development! 🚀");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _drawerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(children: [const Icon(Icons.downloading, color: Colors.blueAccent), const SizedBox(width: 10), Text(title, style: TextStyle(color: _dynamicTextColor, fontWeight: FontWeight.bold))]),
        content: Text(msg, style: TextStyle(color: isDarkMode ? Colors.white70 : Colors.black54)),
        actions: [ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent), onPressed: () => Navigator.pop(context), child: const Text("Got it!"))],
      ),
    );
  }

  /// Opens a panel to submit community issue reports
  void _showReportPanel() {
    String title = widget.language == "Urdu" ? "رپورٹ جمع کریں" : (widget.language == "Roman Urdu" ? "Report Jama Karein" : "Submit Report");
    String hint = widget.language == "Urdu" ? "مسئلہ بیان کریں..." : (widget.language == "Roman Urdu" ? "Masla likhein..." : "Describe the issue...");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _drawerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: TextStyle(color: _dynamicTextColor, fontWeight: FontWeight.bold)),
        content: TextField(
          controller: _reportNoteController,
          maxLines: 4,
          style: TextStyle(color: _dynamicTextColor),
          decoration: InputDecoration(hintText: hint, hintStyle: TextStyle(color: isDarkMode ? Colors.white24 : Colors.black26), filled: true, fillColor: isDarkMode ? Colors.white10 : Colors.black12, border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none)),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(widget.language == "Urdu" ? "منسوخ" : "Cancel")),
          ElevatedButton(
              onPressed: () {
                // Validation to ensure the report text is not empty
                if (_reportNoteController.text.trim().isEmpty) {
                  String errorMsg = widget.language == "Urdu" ? "براہ کرم کچھ لکھیں!" : (widget.language == "Roman Urdu" ? "Baraye maharbani kuch likhein!" : "Please write something!");
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg), backgroundColor: Colors.redAccent));
                } else {
                  Navigator.pop(context);
                  _reportNoteController.clear();
                  String successMsg = widget.language == "Urdu" ? "رپورٹ کامیابی سے جمع ہوگئی ہے!" : "Report submitted successfully!";
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(successMsg), backgroundColor: Colors.green));
                }
              },
              child: Text(widget.language == "Urdu" ? "جمع کریں" : "Submit")
          ),
        ],
      ),
    );
  }

  /// Dialog to edit account details like name, email, and password
  void _showSettingsDialog() {
    String title = widget.language == "Urdu" ? "اکاؤنٹ کی ترتیبات" : "Account Settings";
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: _drawerColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(title, style: TextStyle(color: _dynamicTextColor, fontWeight: FontWeight.bold)),
        content: SingleChildScrollView(
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            _buildSettingsField(widget.language == "Urdu" ? "نام تبدیل کریں" : "Edit Name", _nameController, Icons.person_outline),
            const SizedBox(height: 15),
            _buildSettingsField(widget.language == "Urdu" ? "ای میل اپ ڈیٹ" : "Update Email", _emailController, Icons.contact_mail),
            const SizedBox(height: 15),
            _buildSettingsField(widget.language == "Urdu" ? "پاس ورڈ تبدیل کریں" : "Change Password", _passController, Icons.lock_outline, isPassword: true),
          ]),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(widget.language == "Urdu" ? "منسوخ" : "Cancel", style: const TextStyle(color: Colors.redAccent))),
          ElevatedButton(onPressed: () { setState(() {}); Navigator.pop(context); }, child: Text(widget.language == "Urdu" ? "محفوظ کریں" : "Save")),
        ],
      ),
    );
  }

  /// Builds the grid of filter chips (Public, Private, Cheapest, etc.)
  Widget _buildFilterChipsGrid() {
    Map<String, List<String>> trans = {
      "Public": ["عوامی", "Awaami", "Public"],
      "Private": ["نجی", "Niji", "Private"],
      "Hybrid": ["ہائبرڈ", "Hybrid", "Hybrid"],
      "Cheapest": ["سستا", "Sasta", "Cheapest"],
      "Fastest": ["تیز ترین", "Tez tareen", "Fastest"],
      "Least Walk": ["کم پیدل", "Kam paidal", "Least Walk"],
    };
    int idx = widget.language == "Urdu" ? 0 : (widget.language == "Roman Urdu" ? 1 : 2);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Wrap(
        spacing: 10, runSpacing: 10, alignment: WrapAlignment.center,
        children: [
          _buildFilterItem("🚌 ${trans['Public']![idx]}", const Color(0xFF5DADE2), "Public"),
          _buildFilterItem("🚕 ${trans['Private']![idx]}", const Color(0xFFC0CA33), "Private"),
          _buildFilterItem("🔀 ${trans['Hybrid']![idx]}", const Color(0xFF9DBED9), "Hybrid"),
          _buildFilterItem("💸 ${trans['Cheapest']![idx]}", const Color(0xFFD29999), "Cheapest"),
          _buildFilterItem("⚡ ${trans['Fastest']![idx]}", const Color(0xFFBD6E6E), "Fastest"),
          _buildFilterItem("🚶 ${trans['Least Walk']![idx]}", const Color(0xFF90CAF9), "Least Walk"),
        ],
      ),
    );
  }

  /// Individual filter chip item
  Widget _buildFilterItem(String label, Color color, String key) {
    bool isSelected = selectedFilter == key;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = key),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.28, padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(color: isSelected ? color : color.withOpacity(0.6), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.black, width: 1)),
        child: Center(child: Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))),
      ),
    );
  }

  /// Toggles the saved state of the current route and shows a SnackBar
  void _handleSaveRoute() {
    setState(() { isRouteSaved = !isRouteSaved; });
    String message = isRouteSaved
        ? (widget.language == "Urdu" ? "روٹ محفوظ کر لیا گیا" : "Save route succesfully")
        : (widget.language == "Urdu" ? "روٹ غیر محفوظ کر دیا گیا" : "Route unsave");
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message, style: const TextStyle(color: Colors.white)),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isRouteSaved ? Colors.orangeAccent : Colors.grey[800]));
  }

  @override
  Widget build(BuildContext context) {
    _refreshLanguageText();

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF121212),
      drawer: _buildDrawer(),
      body: Stack(
        children: [
          // Background Mosque Image
          Positioned.fill(child: Opacity(opacity: 0.4, child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover))),
          SafeArea(
            child: Column(
              children: [
                _buildTopBar(),
                _buildFilterChipsGrid(),
                const SizedBox(height: 10),
                // Main Map Viewing Area
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10), decoration: BoxDecoration(border: Border.all(color: Colors.black, width: 1.5), borderRadius: BorderRadius.circular(10)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Stack(
                        children: [
                          // Zoomable Map Interface
                          InteractiveViewer(transformationController: _transformationController, minScale: 1.0, maxScale: 5.0, child: Image.asset('assets/map.jpg', fit: BoxFit.cover, width: double.infinity, height: double.infinity)),
                          // Zoom In/Out Buttons
                          Positioned(top: 10, left: 10, child: Column(children: [_mapBtn(Icons.add, () => setState(() => _transformationController.value *= Matrix4.diagonal3Values(1.2, 1.2, 1.0))), _mapBtn(Icons.remove, () => setState(() => _transformationController.value = Matrix4.identity()))])),
                          // Weather and Advisory Panel
                          Positioned(bottom: 15, left: 15, right: 15, child: Container(padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12), decoration: BoxDecoration(color: Colors.grey.shade800.withOpacity(0.9), borderRadius: BorderRadius.circular(30), border: Border.all(color: Colors.black54)), child: Row(children: [const Text("🌦️", style: TextStyle(fontSize: 18)), const SizedBox(width: 10), Expanded(child: Text(rainAdvisoryText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)))]))),
                        ],
                      ),
                    ),
                  ),
                ),
                _buildBottomNav(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Builds the top search bar and temperature display
  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.menu, color: Colors.white, size: 30), onPressed: () => _scaffoldKey.currentState?.openDrawer()),
          Expanded(
            child: GestureDetector(
              onTap: _openSearchDialog,
              child: Container(
                height: 48, padding: const EdgeInsets.symmetric(horizontal: 15), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(25)),
                child: Row(children: [const Icon(Icons.search, color: Colors.blue), const SizedBox(width: 10), Expanded(child: Text(displaySearchText, style: const TextStyle(color: Colors.black87, fontSize: 13, overflow: TextOverflow.ellipsis)))]),
              ),
            ),
          ),
          const SizedBox(width: 10),
          const Text("23°", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  /// Builds the bottom navigation bar with Save, Offline, and Report icons
  Widget _buildBottomNav() {
    int idx = widget.language == "Urdu" ? 0 : (widget.language == "Roman Urdu" ? 1 : 2);
    List<String> savedTxt = ["محفوظ", "Saved", "Saved"];
    List<String> offlineTxt = ["آف لائن", "Offline", "Offline"];
    List<String> reportsTxt = ["رپورٹس", "Reports", "Reports"];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10), decoration: BoxDecoration(color: _barColor, border: Border(top: BorderSide(color: isDarkMode ? Colors.white10 : Colors.black12))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _navItem(isRouteSaved ? Icons.bookmark : Icons.bookmark_border, savedTxt[idx], isRouteSaved ? Colors.yellow : _dynamicTextColor, _handleSaveRoute),
          _navItem(Icons.notifications_off, offlineTxt[idx], _dynamicTextColor, _showOfflineComingSoon),
          _navItem(Icons.assignment, reportsTxt[idx], _dynamicTextColor, _showReportPanel),
        ],
      ),
    );
  }

  /// Builds the side navigation drawer with all app features
  Widget _buildDrawer() {
    Map<String, List<String>> menu = {
      "Home": ["ہوم", "Home", "Home"],
      "Settings": ["ترتیبات", "Settings", "Settings"],
      "Light": ["لائٹ موڈ", "Light Mode", "Light Mode"],
      "Dark": ["ڈارک موڈ", "Dark Mode", "Dark Mode"],
      "History": ["سفر کی تاریخ", "History", "Travel History"],
      "Notif": ["اطلاعات", "Notifications", "Notifications"],
      "Saved": ["محفوظ راستے", "Saved Routes", "Saved Routes"],
      "ComRep": ["کمیونٹی رپورٹس", "Reports", "Community Reports"],
      "Safety": ["حفاظتی موڈ", "Safety Mode", "Safety Mode"],
      "Help": ["مدد اور سپورٹ", "Help & Support", "Help & Support"],
      "Logout": ["لاگ آؤٹ", "Logout", "Logout"],
    };
    int idx = widget.language == "Urdu" ? 0 : (widget.language == "Roman Urdu" ? 1 : 2);

    return Drawer(
      backgroundColor: _drawerColor,
      child: Column(children: [
        UserAccountsDrawerHeader(decoration: BoxDecoration(color: isDarkMode ? Colors.black87 : Colors.blueAccent), currentAccountPicture: const CircleAvatar(backgroundColor: Colors.white, child: Icon(Icons.person, size: 40)), accountName: Text(_nameController.text, style: const TextStyle(color: Colors.white)), accountEmail: Text(_emailController.text, style: const TextStyle(color: Colors.white70))),
        _drawerTile(Icons.home, menu['Home']![idx], () => Navigator.pop(context)),
        _drawerTile(Icons.settings, menu['Settings']![idx], () { Navigator.pop(context); _showSettingsDialog(); }),
        _drawerTile(isDarkMode ? Icons.wb_sunny : Icons.brightness_4, isDarkMode ? menu['Light']![idx] : menu['Dark']![idx], () { setState(() { isDarkMode = !isDarkMode; }); }),
        _drawerTile(Icons.history, menu['History']![idx], () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => TravelHistoryScreen(language: widget.language)
          ));
        }),
        _drawerTile(Icons.notifications, menu['Notif']![idx], () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(widget.language == "Urdu" ? "کوئی اطلاع نہیں" : "No new notifications"))); }),
        _drawerTile(Icons.bookmark_added, menu['Saved']![idx], () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SavedRoutesScreen(language: widget.language)
          ));
        }),
        _drawerTile(Icons.group, menu['ComRep']![idx], () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => CommunityReportScreen(language: widget.language)
          ));
        }),
        _drawerTile(Icons.security, menu['Safety']![idx], () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SafetyModeScreen(language: widget.language)
          ));
        }),
        _drawerTile(Icons.support_agent, menu['Help']![idx], () {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => HelpSupportScreen(language: widget.language)
          ));
        }),
        const Spacer(),
        _drawerTile(Icons.logout, menu['Logout']![idx], _showLogoutConfirmation),
        const SizedBox(height: 20),
      ]),
    );
  }

  // UI Helpers for Nav items and Drawer tiles
  Widget _navItem(IconData icon, String label, Color color, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(icon, color: color, size: 26), Text(label, style: TextStyle(color: color.withOpacity(0.9), fontSize: 10))]));
  Widget _drawerTile(IconData icon, String title, VoidCallback onTap) => ListTile(leading: Icon(icon, color: _dynamicIconColor), title: Text(title, style: TextStyle(color: _dynamicTextColor)), onTap: onTap);

  // Map control button helper
  Widget _mapBtn(IconData icon, VoidCallback onTap) => GestureDetector(onTap: onTap, child: Container(width: 40, height: 40, margin: const EdgeInsets.only(bottom: 5), alignment: Alignment.center, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.black, width: 1.5)), child: Icon(icon, color: Colors.black, size: 24)));

  // Profile settings field helper
  Widget _buildSettingsField(String label, TextEditingController controller, IconData icon, {bool isPassword = false}) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(label, style: TextStyle(color: isDarkMode ? Colors.white60 : Colors.black54, fontSize: 12)), TextField(controller: controller, obscureText: isPassword, style: TextStyle(color: _dynamicTextColor), decoration: InputDecoration(prefixIcon: Icon(icon, color: Colors.blueAccent, size: 20)))]);

  /// Opens the bottom sheet to plan a route from source to destination
  void _openSearchDialog() {
    String title = widget.language == "Urdu" ? "روٹ پلان کریں" : (widget.language == "Roman Urdu" ? "Route Plan Karein" : "Plan Route");
    String src = widget.language == "Urdu" ? "روانگی" : "Source";
    String dest = widget.language == "Urdu" ? "منزل" : "Destination";
    String btn = widget.language == "Urdu" ? "تلاش کریں" : "SEARCH";

    showModalBottomSheet(
      context: context, isScrollControlled: true, backgroundColor: _drawerColor,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 20, right: 20, top: 20),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          Text(title, style: TextStyle(color: _dynamicTextColor, fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _buildSearchInput(_sourceController, src, Icons.my_location, Colors.green),
          const SizedBox(height: 15),
          _buildSearchInput(_destinationController, dest, Icons.location_on, Colors.red),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                // Validation to ensure both locations are entered
                if (_sourceController.text.trim().isEmpty || _destinationController.text.trim().isEmpty) {
                  String errorMsg = widget.language == "Urdu"
                      ? "براہ کرم روانگی اور منزل درج کریں!"
                      : "Please enter both Source and Destination!";
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errorMsg, style: const TextStyle(color: Colors.white)), backgroundColor: Colors.orangeAccent));
                } else {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => RouteResultScreen(language: widget.language)
                  ));
                }
              },
              child: Text(btn)
          ),
          const SizedBox(height: 20),
        ]),
      ),
    );
  }

  // Generic search input field helper
  Widget _buildSearchInput(TextEditingController controller, String hint, IconData icon, Color col) => TextField(controller: controller, style: TextStyle(color: _dynamicTextColor), decoration: InputDecoration(prefixIcon: Icon(icon, color: col), hintText: hint, hintStyle: TextStyle(color: isDarkMode ? Colors.white38 : Colors.black38), filled: true, fillColor: isDarkMode ? Colors.white10 : Colors.black12));
}
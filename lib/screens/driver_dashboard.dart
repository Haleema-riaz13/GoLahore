import 'package:flutter/material.dart';

class DriverDashboard extends StatefulWidget {
  final String language;
  const DriverDashboard({super.key, required this.language});

  @override
  State<DriverDashboard> createState() => _DriverDashboardState();
}

class _DriverDashboardState extends State<DriverDashboard> {
  bool isOnline = false;

  // --- LOGOUT CONFIRMATION DIALOG ---
  void _showLogoutDialog(bool isUrdu) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Text(
            isUrdu ? "لاگ آؤٹ؟" : "Logout?",
            style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          content: Text(
            isUrdu
                ? "کیا آپ واقعی لاگ آؤٹ کرنا چاہتے ہیں؟"
                : "Are you sure you want to logout from the app?",
            style: const TextStyle(color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(isUrdu ? "کینسل" : "Cancel", style: const TextStyle(color: Colors.grey)),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(isUrdu ? "ہاں، لاگ آؤٹ" : "Yes, Logout", style: const TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isUrdu = widget.language == "Urdu";

    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.black),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: Colors.orangeAccent,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
              accountName: Text(
                isUrdu ? "ہلیمہ" : "Haleema",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              accountEmail: Text(isUrdu ? "پروفائل دیکھیں" : "View Profile"),
            ),

            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDrawerMiniStat(isUrdu ? "سفر" : "Rides", "128"),
                  _buildDrawerMiniStat(isUrdu ? "ریٹنگ" : "Rating", "4.9"),
                  _buildDrawerMiniStat(isUrdu ? "سال" : "Years", "2"),
                ],
              ),
            ),
            const Divider(),

            _buildDrawerItem(Icons.history, isUrdu ? "سفر کی تاریخ" : "Ride History"),

            // Integrated Wallet Navigation
            _buildDrawerItem(
                Icons.account_balance_wallet_outlined,
                isUrdu ? "والٹ / کمائی" : "Wallet & Earnings",
                onTap: () {
                  Navigator.pop(context); // Close Drawer
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WalletScreen(language: widget.language))
                  );
                }
            ),

            _buildDrawerItem(Icons.notifications_none, isUrdu ? "اطلاعات" : "Notifications"),
            _buildDrawerItem(Icons.star_border, isUrdu ? "ریٹنگ اور فیڈ بیک" : "Ratings & Feedback"),

            const Divider(),

            _buildDrawerItem(Icons.settings_outlined, isUrdu ? "سیٹنگز" : "Settings"),
            _buildDrawerItem(Icons.dark_mode_outlined, isUrdu ? "ڈارک تھیم" : "Dark Theme", isSwitch: true),
            _buildDrawerItem(Icons.help_outline, isUrdu ? "مدد اور سپورٹ" : "Help & Support"),

            const Spacer(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: Text(
                isUrdu ? "لاگ آؤٹ" : "Logout",
                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
              onTap: () => _showLogoutDialog(isUrdu),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),

      body: Stack(
        children: [
          Container(
            color: Colors.grey.shade200,
            width: double.infinity,
            height: double.infinity,
            child: const Center(
              child: Icon(Icons.map_outlined, size: 100, color: Colors.grey),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Builder(
                    builder: (context) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: IconButton(
                            icon: const Icon(Icons.menu, color: Colors.black),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          ),
                        ),
                        _buildHeaderEarnings(isUrdu ? "آج کی کمائی" : "Today's Total", "Rs. 1,450"),
                        _buildRatingBadge("4.9 ★"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (isOnline) _buildNewRideRequest(isUrdu),
                  const SizedBox(height: 15),
                  Text(
                    isOnline
                        ? (isUrdu ? "آپ آن لائن ہیں" : "YOU ARE ONLINE")
                        : (isUrdu ? "آپ آف لائن ہیں" : "YOU ARE OFFLINE"),
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isOnline ? Colors.green : Colors.red,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    isOnline
                        ? (isUrdu ? "سواری ka انتظار ہے..." : "Looking for nearby rides...")
                        : (isUrdu ? "ڈیوٹی شروع کرنے کے لیے بٹن دبائیں" : "Go online to see ride offers"),
                    style: const TextStyle(color: Colors.black87, fontSize: 13),
                  ),
                  const SizedBox(height: 25),
                  GestureDetector(
                    onTap: () => setState(() => isOnline = !isOnline),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        color: isOnline ? Colors.red : Colors.green,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (isOnline ? Colors.red : Colors.green).withValues(alpha: 0.3),
                            blurRadius: 12,
                            spreadRadius: 4,
                          )
                        ],
                      ),
                      child: Icon(
                        isOnline ? Icons.power_settings_new : Icons.play_arrow,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    isOnline
                        ? (isUrdu ? "بند کریں" : "GO OFFLINE")
                        : (isUrdu ? "شروع کریں" : "GO ONLINE"),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {bool isSwitch = false, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.black87),
      title: Text(title, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500)),
      // FIX: activeColor deprecated, using activeThumbColor and activeTrackColor
      trailing: isSwitch ? Switch(
        value: false,
        onChanged: (v) {},
        activeThumbColor: Colors.orangeAccent,
        activeTrackColor: Colors.orangeAccent.withValues(alpha: 0.5),
      ) : const Icon(Icons.chevron_right, size: 18, color: Colors.black26),
      onTap: onTap ?? () {},
    );
  }

  Widget _buildDrawerMiniStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildHeaderEarnings(String label, String amount) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: Colors.black54)),
          Text(amount, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
        ],
      ),
    );
  }

  Widget _buildRatingBadge(String rating) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]),
      child: Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 12)),
    );
  }

  Widget _buildNewRideRequest(bool isUrdu) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.orangeAccent.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          const Icon(Icons.notifications_active, color: Colors.orange),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isUrdu ? "نئی سواری دستیاب ہے!" : "New Ride Available!",
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
                Text(
                  isUrdu ? "2.5 کلومیٹر دور" : "2.5 km away • Model Town",
                  style: const TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Text(isUrdu ? "دیکھیں" : "VIEW", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}

// WalletScreen class follows... (No changes needed there)

// --- NEW WALLET SCREEN INTEGRATION ---
class WalletScreen extends StatelessWidget {
  final String language;
  const WalletScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    bool isUrdu = language == "Urdu";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          isUrdu ? "والٹ اور کمائی" : "Wallet & Earnings",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBalanceCard(isUrdu),
            _buildWeeklyGraph(isUrdu),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isUrdu ? "حالیہ لین دین" : "Recent Transactions",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(isUrdu ? "تمام دیکھیں" : "See All", style: const TextStyle(color: Colors.orangeAccent)),
                  ),
                ],
              ),
            ),
            _buildTransactionItem(isUrdu ? "سواری مکمل" : "Ride Completed", "Rs. 450", "12:30 PM", true),
            _buildTransactionItem(isUrdu ? "رقم نکلوائی" : "Withdrawal", "-Rs. 2,000", "Yesterday", false),
            _buildTransactionItem(isUrdu ? "سواری مکمل" : "Ride Completed", "Rs. 320", "Yesterday", true),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard(bool isUrdu) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        crossAxisAlignment: isUrdu ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(isUrdu ? "موجودہ بیلنس" : "Current Balance", style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const SizedBox(height: 10),
          const Text("Rs. 8,240.00", style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orangeAccent, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              onPressed: () {},
              child: Text(isUrdu ? "رقم نکالیں" : "Withdraw", style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWeeklyGraph(bool isUrdu) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(isUrdu ? "ہفتہ وار کارکردگی" : "Weekly Performance", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 15),
          Container(
            height: 120,
            decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(15)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildBar("Mon", 40), _buildBar("Tue", 70), _buildBar("Wed", 50),
                _buildBar("Thu", 90), _buildBar("Fri", 65), _buildBar("Sat", 30),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, double height) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(height: height, width: 12, decoration: BoxDecoration(color: height > 70 ? Colors.orangeAccent : Colors.black, borderRadius: BorderRadius.circular(4))),
        const SizedBox(height: 5),
        Text(day, style: const TextStyle(fontSize: 10, color: Colors.grey)),
      ],
    );
  }

  Widget _buildTransactionItem(String title, String amount, String time, bool isIncome) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isIncome ? Colors.green.withValues(alpha: 0.1) : Colors.red.withValues(alpha: 0.1),
        child: Icon(isIncome ? Icons.add_circle_outline : Icons.remove_circle_outline, color: isIncome ? Colors.green : Colors.red),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(time, style: const TextStyle(fontSize: 12)),
      trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold, color: isIncome ? Colors.green : Colors.red)),
    );
  }
}
import 'package:flutter/material.dart';
import '../widgets/custom_ui.dart';
import '../utils/transitions.dart';

class SavedRoutesScreen extends StatelessWidget {
  final String language; // Holds the user's selected language (Urdu, Roman Urdu, or English)

  const SavedRoutesScreen({super.key, this.language = "English"});

  // --- Translation Helper Method ---
  // Returns the correct string literal based on the current language state
  String _t(String ur, String ro, String en) {
    if (language == "Urdu") return ur;
    if (language == "Roman Urdu") return ro;
    return en;
  }

  @override
  Widget build(BuildContext context) {
    // Sample static data representing the user's saved transit routes
    // This typically maps to a user's 'Favorites' table in a database
    final List<Map<String, String>> savedRoutes = [
      {"from": "Liberty Chowk", "to": "Arfa Tower", "type": "Public"},
      {"from": "Model Town", "to": "Badshahi Mosque", "type": "Private"},
      {"from": "Gulberg III", "to": "Lahore Cantt", "type": "Hybrid"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A1A),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context), // Logic to pop the current screen off the navigation stack
        ),
        title: Text(
          _t("محفوظ راستے", "Saved Routes", "Saved Routes"),
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Stack(
        children: [
          // Background Layer: Themed mosque image with low opacity for branding and UI consistency
          Positioned.fill(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/mosque.jpg', fit: BoxFit.cover),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Section Header: Localized text explaining the purpose of this screen
                Text(
                  _t("آپ کے پسندیدہ سفر", "Aap ke pasandida safar", "Your Favorite Journeys"),
                  style: const TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 20),

                // Main List: Rendering saved journeys using a builder for optimal memory efficiency
                Expanded(
                  child: ListView.builder(
                    itemCount: savedRoutes.length,
                    itemBuilder: (context, index) {
                      return _buildSavedRouteTile(
                        savedRoutes[index]['from']!,
                        savedRoutes[index]['to']!,
                        savedRoutes[index]['type']!,
                        context,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget to build individual route information cards with action buttons
  Widget _buildSavedRouteTile(String from, String to, String type, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E), // Dark background for the card
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white12),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(15),
        // Leading: Icon representing the transport type
        leading: const CircleAvatar(
          backgroundColor: Colors.blueAccent,
          child: Icon(Icons.directions_bus, color: Colors.white),
        ),
        // Title: Displays the Source to Destination path
        title: Text(
          "$from → $to",
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        // Subtitle: Shows the transport preference (Public/Private/Hybrid)
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 5),
          child: Text(
            _t("ترجیح: $type ٹرانسپورٹ", "Preference: $type Transport", "Preference: $type Transport"),
            style: const TextStyle(color: Colors.white54),
          ),
        ),
        // Trailing: Bookmark icon allowing users to remove the item from favorites
        trailing: IconButton(
          icon: const Icon(Icons.bookmark, color: Colors.yellow),
          onPressed: () {
            // Snackbar provides immediate visual feedback when a user un-bookmarks a route
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(_t("راستہ محفوظ فہرست سے نکال دیا گیا", "Route saved se hata diya gaya", "Route removed from saved")),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody(context));
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppBar(title: Text("Profile"), backgroundColor: Colors.white),
            const SizedBox(height: 20),
            const Text(
              "User Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Placeholder for user information
            Text("Name: John Doe"),
            Text("Email: john.doe@example.com"),
            Text("Phone: +1234567890"),
            const SizedBox(height: 20),
            Text("role: farmer"),
            Text("address: 123 Farm Lane"),
          ],
        ),
      ),
    );
  }
}

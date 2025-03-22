import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/profile.jpg"), // Ganti dengan image dari assets
            ),
            SizedBox(height: 10),
            Text(
              "Hexa Freedom",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "info@hexafreedom.com",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone"),
              subtitle: Text("+60123456789"),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Location"),
              subtitle: Text("Kuala Lumpur, Malaysia"),
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Tambah function untuk edit profile nanti
              },
              child: Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}


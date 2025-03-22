import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
// import 'dart:io';
import 'dart:io' if (dart.library.html) 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:html' as html;


class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

    void openWhatsApp(String phone) async {
    String url = "https://wasap.my/$phone"; // Format WhatsApp API
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Error: Could not launch $url");
    }
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Share Your Phone Number"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Your Name"),
              ),
              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(labelText: "Your Phone Number"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text.trim();
                String phone = phoneController.text.trim();
                if (name.isNotEmpty && phone.isNotEmpty) {
                  if (kIsWeb) {
                    _sendWhatsApp(name, phone); // Untuk Web, terus buka WhatsApp
                  } else {
                    openWhatsApp(phone); // Untuk Mobile, buka WhatsApp app
                  }
                  Navigator.pop(context);
                } else {
                  print("Error: Name or phone is empty");
                }
              },
              child: Text("Submit"),
            ),
          ],
        );
      },
    );
  }

  String _generateVCF(String name, String phone) {
    return "BEGIN:VCARD\nVERSION:3.0\nFN:$name\nTEL:$phone\nEND:VCARD";
  }

  void _sendWhatsApp(String name, String phone) async {
    final vcfText = _generateVCF(name, phone);
    final text = Uri.encodeComponent(vcfText);

    print("Generated VCF:\n$vcfText"); // Debug log

    if (kIsWeb) {
      final url = "https://wa.me/?text=$text";
      print("Opening WhatsApp Web: $url"); // Debug log
      html.window.open(url, "_blank");
    } else {
      final url = "whatsapp://send?text=$text";
      print("Opening WhatsApp Mobile: $url"); // Debug log
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        print("Error: WhatsApp tidak tersedia");
      }
    }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage:
                  AssetImage("images/hf.png"), // Ganti dengan image dari assets
            ),
            SizedBox(height: 10),
            // Text(
            //   "Hexa Freedom",
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            Text(
              "hexafreedom@gmail.com",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone"),
              subtitle: Text("+601118872966"),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Location"),
              subtitle: Text("Cyberjaya, Selangor"),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: _showInputDialog,
                child: Text("Share your phone number"),
              ),
            ),

            SizedBox(height: 20),

            Container(
              width: MediaQuery.of(context).size.width,
              child: ElevatedButton(
                onPressed: () {
                  // Tambah function untuk edit profile nanti
                  openWhatsApp("+601118872966");
                },
                child: Text("Chat on Whatsapp"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

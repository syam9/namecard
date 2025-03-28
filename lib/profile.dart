import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
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
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController orgController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController noteController = TextEditingController();

  // void openWhatsApp(String phone) async {
  //   String url = "https://wasap.my/$phone"; // Format WhatsApp API
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  //   } else {
  //     print("Error: Could not launch $url");
  //   }
  // }

  void openWhatsApp(String phone) async {
    // String url = "whatsapp://send?phone=$phone"; // Link rasmi API WhatsApp
    String url = "https://wa.me/$phone";
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      print("Error: WhatsApp tidak dapat dibuka");
    }
  }

  void _showInputDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Share Your Contact Details"),
          content: Container(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRoundedTextField(nameController, "Your Name"),
                  _buildRoundedTextField(phoneController, "Your Phone Number",
                      TextInputType.phone),
                  _buildRoundedTextField(emailController, "Your Email",
                      TextInputType.emailAddress),
                  _buildRoundedTextField(addressController, "Your Address"),
                  _buildRoundedTextField(orgController, "Your Organization"),
                  _buildRoundedTextField(titleController, "Your Job Title"),
                  _buildRoundedTextField(
                      websiteController, "Your Website", TextInputType.url),
                  _buildRoundedTextField(noteController, "Notes"),
                ],
              ),
            ),
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
                String email = emailController.text.trim();
                String address = addressController.text.trim();
                String organization = orgController.text.trim();
                String title = titleController.text.trim();
                String website = websiteController.text.trim();
                String note = noteController.text.trim();

                if (name.isNotEmpty && phone.isNotEmpty) {
                  if (kIsWeb) {
                    _sendWhatsApp(name, phone, email, address, organization,
                        title, website, note);
                  } else {
                    openWhatsApp(phone);
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

  Widget _buildRoundedTextField(TextEditingController controller, String label,
      [TextInputType keyboardType = TextInputType.text]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          hintText: label, // Letak hint text macam placeholder
          filled: true,
          fillColor: Colors.grey[200], // Background color
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12), // Adjust radius
            borderSide: BorderSide.none, // Remove border line
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: 14, horizontal: 16), // Padding dalam input
        ),
      ),
    );
  }

  String _generateVCF(String name, String phone, String email, String address,
      String org, String title, String website, String note) {
    String vCard = "BEGIN:VCARD\nVERSION:3.0";

    if (name.isNotEmpty) vCard += "\nFN:$name";
    if (phone.isNotEmpty) vCard += "\nTEL:$phone";
    if (email.isNotEmpty) vCard += "\nEMAIL:$email";
    if (org.isNotEmpty) vCard += "\nORG:$org";
    if (title.isNotEmpty) vCard += "\nTITLE:$title";
    if (address.isNotEmpty) vCard += "\nADR:$address";
    if (website.isNotEmpty) vCard += "\nURL:$website";
    if (note.isNotEmpty) vCard += "\nNOTE:$note";

    vCard += "\nEND:VCARD";
    return vCard;
  }

  void _sendWhatsApp(String name, String phone, String email, String address,
      String org, String title, String website, String note) async {
    final vcfText =
        _generateVCF(name, phone, email, address, org, title, website, note);
    final text = Uri.encodeComponent(vcfText);
    const String targetNumber =
        "601118872966"; // Pastikan nombor dalam format antarabangsa tanpa '+'

    print("Generated VCF:\n$vcfText"); // Debug log

    if (kIsWeb) {
      final url = "https://wa.me/$targetNumber?text=$text";
      print("Opening WhatsApp Web: $url"); // Debug log
      html.window.open(url, "_blank");
    } else {
      final url = "whatsapp://send?phone=$targetNumber&text=$text";
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
              // backgroundImage:
              //     AssetImage("images/hf.png"), // Ganti dengan image dari assets
              backgroundImage: NetworkImage(
                "https://ia601309.us.archive.org/18/items/123_20250322/123.png",
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Hexa Freedom",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              "hexafreedom@gmail.com",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    child: ElevatedButton(
                      onPressed: () {
                        // Action untuk Pay
                        launchUrl(Uri.parse(
                            "https://buymeacoffee.com/syam96")); // Pastikan category ada 'url'
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("Pay"),
                    ),
                  ),
                ),
                const SizedBox(width: 10), // Jarak antara dua butang
                Expanded(
                  flex: 1,
                  child: Container(
                    child: OutlinedButton(
                      onPressed: () {
                        // Action untuk QRCode Payment
                        launchUrl(Uri.parse(
                            "https://buymeacoffee.com/syam96")); // Pastikan category ada 'url'
                      },
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text("Donate"),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // ListTile(
            //   leading: Icon(Icons.phone),
            //   title: Text("Phone"),
            //   subtitle: Text("+601118872966"),
            // ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("Phone"),
              subtitle: Text("+601118872966"),
              trailing: IconButton(
                icon: Icon(Icons.content_copy), // Ikon salin
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: "+601118872966"));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Phone number copied!")),
                  );
                },
              ),
            ),
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text("Location"),
              subtitle: Text("Cyberjaya, Selangor"),
            ),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF00abb7), width: 1),
                ),
                onPressed: _showInputDialog,
                child: const Text("Share Your Phone Number"),
              ),
            ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  side: const BorderSide(color: Color(0xFF00abb7), width: 1),
                ),
                onPressed: () {
                  openWhatsApp("+601118872966");
                },
                child: const Text("Chat on Whatsapp"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

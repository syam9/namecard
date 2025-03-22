import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path_provider/path_provider.dart';
// import 'dart:io';
import 'dart:io' if (dart.library.html) 'dart:html' as html;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:ui_web' as ui;

// import 'package:flutter/foundation.dart';

// // Import hanya jika bukan Web
// if (!kIsWeb) {
//   import 'dart:io';
//   import 'package:path_provider/path_provider.dart';
// }

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
      throw "Could not launch $url";
    }
  }

  // void _showInputDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Share Your Phone Number"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: nameController,
  //               decoration: InputDecoration(labelText: "Your Name"),
  //             ),
  //             TextField(
  //               controller: phoneController,
  //               keyboardType: TextInputType.phone,
  //               decoration: InputDecoration(labelText: "Your Phone Number"),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: Text("Cancel"),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               String name = nameController.text;
  //               String phone = phoneController.text;
  //               if (name.isNotEmpty && phone.isNotEmpty) {
  //                 File vcfFile = await _generateVCF(name, phone);
  //                 _sendWhatsApp(vcfFile);
  //                 Navigator.pop(context);
  //               }
  //             },
  //             child: Text("Submit"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
              String name = nameController.text;                                
              String phone = phoneController.text;                                
              if (name.isNotEmpty && phone.isNotEmpty) {                                
                await _generateVCF(name, phone); // Untuk Web, dia download terus
                if (!kIsWeb) {
                  // _sendWhatsApp(File('')); // Untuk Mobile, send ke WhatsApp
                  _sendWhatsApp(name, phone);
                }
                Navigator.pop(context);                                
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


//   Future<void> _generateVCF(String name, String phone) async {
//   String vcfContent = """
// BEGIN:VCARD
// VERSION:3.0
// FN:$name
// TEL:$phone
// END:VCARD
//   """;
//
//   if (kIsWeb) {
//     // **Untuk Web** -> Buat fail & download
//     final blob = html.Blob([vcfContent], 'text/vcard');
//     final url = html.Url.createObjectUrlFromBlob(blob);
//     final anchor = html.AnchorElement(href: url)
//       ..setAttribute("download", "contact.vcf")
//       ..click();
//     html.Url.revokeObjectUrl(url);
//   } else {
//     // **Untuk Android/iOS** -> Simpan fail dalam directory
//     final directory = await getTemporaryDirectory();
//     final filePath = "${directory.path}/contact.vcf";
//     final file = File(filePath);
//     await file.writeAsString(vcfContent);
//     _sendWhatsApp(file);
//   }
// }

//   Future<File> _generateVCF(String name, String phone) async {
//     String vcfContent = """
// BEGIN:VCARD
// VERSION:3.0
// FN:$name
// TEL:$phone
// END:VCARD
//     """;
//
//     final directory = await getTemporaryDirectory();
//     final filePath = "${directory.path}/contact.vcf";
//     final file = File(filePath);
//     await file.writeAsString(vcfContent);
//     return file;
//   }

  //  void _sendWhatsApp(File file) async {
  //   String phoneNumber = "+601118872966"; // Ganti dengan nombor WhatsApp kau
  //   String message = "Here is my contact info:";
  //
  //   Uri uri = Uri.parse("https://wasap.my/$phoneNumber/?text=$message");
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     print("Could not launch WhatsApp");
  //   }
  // }

// void _sendWhatsApp(String name, String phone) async {
//   final text = Uri.encodeComponent("Nama: $name\nPhone: $phone");
//
//   if (kIsWeb) {
//     // Untuk Web, buka WhatsApp Web
//     final url = "https://wasap.my/?text=$text";
//     html.window.open(url, "_blank");
//   } else {
//     // Untuk Mobile, buka WhatsApp App
//     final url = "whatsapp://send?text=$text";
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       print("WhatsApp tidak tersedia");
//     }
//   }
// }

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
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("WhatsApp tidak tersedia");
    }
  }
}



// void _sendWhatsApp(String name, String phone, {File? file}) async {
//   final text = "Nama: $name\nPhone: $phone";
//
//   if (kIsWeb) {
//     // Untuk Web, buka WhatsApp Web
//     final url = Uri.encodeFull("https://wa.me/?text=$text");
//     await launch(url);
//   } else {
//     // Untuk Mobile, hantar .vcf file
//     if (file != null) {
//       final uri = Uri.file(file.path);
//       await launch("whatsapp://send?phone=&text=$text&attachment=${uri.toString()}");
//     } else {
//       await launch("whatsapp://send?phone=&text=$text");
//     }
//   }
// }


  // void _sendWhatsApp(File file) async {
  //   if (kIsWeb) {
  //     print("WhatsApp file sharing is not supported on Web.");
  //     return;
  //   }
  //
  //   String phoneNumber = "+601118872966"; // Tukar dengan nombor WhatsApp kau
  //   String message = "Here is my contact info:";
  //
  //   Uri uri = Uri.parse("https://wasap.my/$phoneNumber/?text=$message");
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri, mode: LaunchMode.externalApplication);
  //   } else {
  //     print("Could not launch WhatsApp");
  //   }
  // }

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

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Hexa Freedom Enterprise"),
            accountEmail: Text("202303249281 (003535070-T)"),
            // currentAccountPicture: CircleAvatar(
            //   backgroundColor: Colors.white,
            //   child: Text(
            //     "HF",
            //     style: TextStyle(fontSize: 24.0, color: Colors.black),
            //   ),
            // ),
            currentAccountPicture: CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                "https://ia601309.us.archive.org/18/items/123_20250322/123.png",
              ),
            ),
          ),

          ListTile(
            title: Text(
              "Past Projects",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("UIUX Designer"),
            onTap: () async {
              // Navigator.pop(context);
              final Uri url = Uri.parse(
                  "https://owner.mescoffee.my/uiux-designer/"); // Ganti dengan link sebenar
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                throw "Could not launch $url";
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.graphic_eq),
            title: Text("Graphic Design"),
            onTap: () async {
              // Navigator.pop(context);
              final Uri url = Uri.parse(
                  "https://owner.mescoffee.my/poster/"); // Ganti dengan link sebenar
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                throw "Could not launch $url";
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.movie_filter),
            title: Text("Videpgraphy"),
            onTap: () async {
              // Navigator.pop(context);
              final Uri url = Uri.parse(
                  "https://owner.mescoffee.my/videography/"); // Ganti dengan link sebenar
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                throw "Could not launch $url";
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text("Programming"),
            onTap: () async {
              // Navigator.pop(context);
              final Uri url = Uri.parse(
                  "https://owner.mescoffee.my/developer/"); // Ganti dengan link sebenar
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                throw "Could not launch $url";
              }
            },
          ),
          Divider(),
          // ListTile(
          //   leading: Icon(Icons.logout),
          //   title: Text("Logout"),
          //   onTap: () {
          //     Navigator.pop(context);
          //   },
          // ),
        ],
      ),
    );
  }
}

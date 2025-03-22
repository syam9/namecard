import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MescoffeePage extends StatefulWidget {
  @override
  _MescoffeePageState createState() => _MescoffeePageState();
}

class _MescoffeePageState extends State<MescoffeePage> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw "Could not launch $url";
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("MESCOFFEE"),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.05,
              vertical: screenHeight * 0.02,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // FadeInDown(
                //   child: Text(
                //     "Discover the Future with Our App!",
                //     style: TextStyle(
                //       fontSize: screenWidth * 0.06,
                //       fontWeight: FontWeight.bold,
                //     ),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(height: screenHeight * 0.02),
                BounceInUp(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      "https://images.pexels.com/photos/683039/pexels-photo-683039.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                      height: screenHeight * 0.3,
                      width: screenWidth * 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.05),
                FadeIn(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                    child: Text(
                      "Experience the perfect brew with MESCOFFEE, where passion meets precision in every sip. From premium beans to the final silky froth, we craft each cup with dedication bringing you bold flavors, rich aromas, and the ultimate coffee experience.\n\n🔸 Brewed with skill, served with soul\n🔸 Every cup tells a story\n🔸 More than coffee, it’s an experience.",
                      style: TextStyle(fontSize: screenWidth * 0.04),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                ZoomIn(
                  child: ElevatedButton(
                    onPressed: () {
                      _launchURL("https://play.google.com/store/apps/details?id=com.syamp.mescoffee&pcampaignid=web_share");
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1,
                        vertical: screenHeight * 0.02,
                      ),
                      textStyle: TextStyle(fontSize: screenWidth * 0.045),
                    ),
                    child: Text("Install Now"),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                SlideInLeft(
                  child: TextButton(
                    onPressed: () {
                      _launchURL("https://mescoffee.my");
                    },
                    child: Text(
                      "Open Website",
                      style: TextStyle(fontSize: screenWidth * 0.04),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

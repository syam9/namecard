import 'package:flutter/material.dart';
import './graphicdesignPage.dart';
import './uiuxDesignerPage.dart';
import './appdevelopmentPage.dart';
import './videographyPage.dart';
import './programmingPage.dart';

class ITServicesPage extends StatelessWidget {
  // final List<Map<String, String>> services = [
  //   {"title": "UIUX Designer", "icon": "💻"},
  //   {"title": "Graphic Design", "icon": "🎨"},
  //   {"title": "App Development", "icon": "📱"},
  //   {"title": "Videography", "icon": " 🎥r"},
  //   {"title": "Programming", "icon": "👨‍💻"},
  // ];

  final List<Map<String, dynamic>> services = [
    {"title": "UIUX Designer", "icon": "💻", "page": UiuxDesignerPage()},
    {"title": "Graphic Design", "icon": "🎨", "page": GraphicDesignPage()},
    {"title": "App Development", "icon": "📱", "page": AppDevelopmentPage()},
    {"title": "Videography", "icon": "🎥", "page": VideographyPage()},
    {"title": "Programming", "icon": "👨‍💻", "page": ProgrammingPage()},
  ];

  void _applyNow(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Application submitted!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth > 600 ? 3 : 2; // Tablet: 3, Phone: 2

    return Scaffold(
      appBar: AppBar(title: Text("IT Services"), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 0,
                    child: InkWell(
                      onTap: () {
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   SnackBar(
                        //       content: Text(
                        //           "${services[index]['title']} selected!")),
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => services[index]["page"]),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(services[index]['icon']!,
                              style: TextStyle(fontSize: 40)),
                          SizedBox(height: 10),
                          Text(
                            services[index]['title']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(16.0),
          //   child: Container(
          //     width: MediaQuery.of(context).size.width,
          //     child: ElevatedButton(
          //       onPressed: () => _applyNow(context),
          //       style: ElevatedButton.styleFrom(
          //         shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(10),
          //         ),
          //         padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
          //         textStyle: TextStyle(fontSize: 18),
          //       ),
          //       child: Text("Apply Now"),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

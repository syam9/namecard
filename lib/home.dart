import 'package:flutter/material.dart';


class HomeTab extends StatefulWidget {
  @override
  _ReelsPreviewPageState createState() => _ReelsPreviewPageState();
}

class _ReelsPreviewPageState extends State<HomeTab> {
// class HomeTab extends StatelessWidget {
      final List<String> reels = [
    "https://images.pexels.com/photos/716276/pexels-photo-716276.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/8761323/pexels-photo-8761323.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/8761513/pexels-photo-8761513.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://images.pexels.com/photos/8761541/pexels-photo-8761541.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
    "https://ia601309.us.archive.org/18/items/123_20250322/123.png",
    "https://ia601309.us.archive.org/18/items/123_20250322/123.png",
  ];

  // final List<String> reels = [
  //   "https://source.unsplash.com/random/100x100?people",
  //   "https://source.unsplash.com/random/100x100?city",
  //   "https://source.unsplash.com/random/100x100?nature",
  //   "https://source.unsplash.com/random/100x100?ocean",
  //   "https://source.unsplash.com/random/100x100?forest",
  //   "https://source.unsplash.com/random/100x100?mountain",
  // ];

  final Set<int> openedReels = {}; // Simpan reels yang dah dibuka


  @override
  Widget build(BuildContext context) {
          double screenWidth = MediaQuery.of(context).size.width;
    double reelSize = screenWidth * 0.20; // Responsive circle size
    return Scaffold(
      body:
     Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Teks "Reels"
            // const Padding(
            //   padding: EdgeInsets.symmetric(vertical: 10),
            //   child: Text(
            //     "Activities",
            //     style: TextStyle(
            //       fontSize: 20,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),

            SizedBox(height: 30),
            // ListView Reels (Bulat & Scrollable)
            SizedBox(
              height: reelSize + 30, // Adaptive height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: reels.length,
                itemBuilder: (context, index) {
                  final isOpened = openedReels.contains(index);

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        openedReels.add(index);
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(3), // Border spacing
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: isOpened
                                  ? null
                                  : LinearGradient(
                                      colors: [Colors.blue, Colors.green],
                                    ),
                            ),
                            child: ClipOval(
                              child: Image.network(
                                reels[index],
                                width: reelSize,
                                height: reelSize,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            "Event ${index + 1}",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 20),

            // Teks "Projects"
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                "Active Projects",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // Expanded GridView
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Auto adjust ikut skrin
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.2,
                ),
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
                            child: Image.network(
                              category.image,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category.title,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      );

      
      // return Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: GridView.builder(
      //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2, // Auto adjust ikut skrin
      //       crossAxisSpacing: 10,
      //       mainAxisSpacing: 10,
      //       childAspectRatio: 1.2,
      //     ),
      //     itemCount: categories.length,
      //     itemBuilder: (context, index) {
      //       final category = categories[index];
      //       return Card(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(10),
      //         ),
      //         elevation: 4,
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             Expanded(
      //               child: ClipRRect(
      //                 borderRadius:
      //                     const BorderRadius.vertical(top: Radius.circular(10)),
      //                 child: Image.network(
      //                   category.image,
      //                   width: double.infinity,
      //                   fit: BoxFit.cover,
      //                 ),
      //               ),
      //             ),
      //             Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Text(
      //                 category.title,
      //                 style: const TextStyle(
      //                     fontSize: 16, fontWeight: FontWeight.bold),
      //               ),
      //             ),
      //           ],
      //         ),
      //       );
      //     },
      //   ),
      // );
  }
}

class Category {
  final String title;
  final String image;

  Category({required this.title, required this.image});
}

final List<Category> categories = [
  Category(
      title: "IT Services",
      image:
          "https://images.pexels.com/photos/2102416/pexels-photo-2102416.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
  Category(
      title: "MESCOFFEE",
      image:
          "https://images.pexels.com/photos/1924951/pexels-photo-1924951.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
];

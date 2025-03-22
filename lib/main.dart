import 'package:flutter/material.dart';
import 'drawer.dart';
import 'home.dart';
import 'profile.dart';
import 'dart:ui';

Map<int, Color> colorCodes = {
  50: Color(0xFFE0F7FA),
  100: Color(0xFFB2EBF2),
  200: Color(0xFF80DEEA),
  300: Color(0xFF4DD0E1),
  400: Color(0xFF26C6DA),
  500: Color(0xFF00ABB7), // Warna utama
  600: Color(0xFF0097A7),
  700: Color(0xFF00838F),
  800: Color(0xFF006064),
  900: Color(0xFF004D40),
};

MaterialColor customSwatch = MaterialColor(0xFF00ABB7, colorCodes);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: customSwatch,
        scaffoldBackgroundColor: Colors.grey[200], // Background app
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF00abb7), // Warna AppBar
          foregroundColor: Colors.white, // Warna teks dalam AppBar
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: Color(0xFF00abb7), // Warna ikon terpilih
          unselectedItemColor: Colors.grey, // Warna ikon tak dipilih
        ),
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenPageState createState() => _DashboardScreenPageState();
}

class _DashboardScreenPageState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  // Senarai pages untuk setiap tab
  final List<Widget> _pages = [
    HomeTab(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Jumlah tab
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text("Hexa Freedom"),
        // ),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(100), // Tinggi AppBar
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Gambar background
              Positioned.fill(
                child: Image.network(
                  'https://images.pexels.com/photos/1181271/pexels-photo-1181271.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  fit: BoxFit.cover, // Pastikan gambar penuh
                ),
              ),

              // Overlay untuk blur & gelap (di Web kadang-kadang BackdropFilter tak jalan)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5), // Lapisan gelap
                  ),
                  child: ClipRect(
                    child: BackdropFilter(
                      filter:
                          ImageFilter.blur(sigmaX: 2, sigmaY: 2), // Blur effect
                      child: Container(
                        color: Colors.black
                            .withOpacity(0.2), // Extra gelap supaya lebih jelas
                      ),
                    ),
                  ),
                ),
              ),

              // AppBar Transparent supaya teks tak kacau gambar
              AppBar(
                backgroundColor: Colors.transparent, // Buat AppBar lutsinar
                elevation: 0, // Hilangkan shadow
                title: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Text(
                      "Empowering You with Smart Solutions!",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7), // Warna putih
                        fontSize: 15, // Saiz font kecil
                        fontStyle: FontStyle.italic, // Italic
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      "Design > Code > Coffee :)",
                      style: TextStyle(
                        color: Colors.white, // Warna putih
                        fontSize: 15, // Saiz font kecil
                        fontWeight: FontWeight.bold, // Italic
                      ),
                    ),
                  ],
                ),
                centerTitle: true,
              ),
            ],
          ),
        ),
//           appBar: PreferredSize(
//   preferredSize: Size.fromHeight(100), // Tinggikan AppBar
//   child: Stack(
//     fit: StackFit.expand,
//     children: [
//       Positioned.fill(
//         child: Image.network(
//           'https://images.pexels.com/photos/2102416/pexels-photo-2102416.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
//           fit: BoxFit.cover, // Pastikan gambar penuh dalam ruang
//         ),
//       ),
//       AppBar(
//         backgroundColor: Colors.transparent, // Biar gambar jadi background
//         elevation: 0, // Hilangkan shadow
//         title: Text(
//           "Your App Title",
//           style: TextStyle(
//             color: Colors.white, // Teks putih supaya jelas atas gambar
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         centerTitle: true,
//       ),
//     ],
//   ),
// ),

        drawer: DrawerWidget(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Color(0xFF00abb7), // Warna ikon yang aktif
          unselectedItemColor: Colors.grey, // Warna ikon yang tak aktif
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_max),
              label: "Dashboard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people_outlined),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

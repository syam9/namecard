import 'package:flutter/material.dart';
import 'drawer.dart';
import 'home.dart';
import 'profile.dart';

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
        appBar: AppBar(
          title: const Text("Hexa Freedom"),
        ),
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
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

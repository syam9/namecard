import 'package:flutter/material.dart';
import 'drawer.dart';
import 'home.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
          title: const Text("Hexa Freedom Enterprise"),
        ),
        drawer: DrawerWidget(),
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.blue, // Warna ikon yang aktif
          unselectedItemColor: Colors.grey, // Warna ikon yang tak aktif
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.coffee),
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}

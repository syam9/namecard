import 'package:flutter/material.dart';
import 'drawer.dart';
import 'dart:typed_data';
import 'home.dart';
import 'profile.dart';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // runApp(const MyApp());

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFormSubmitted = prefs.getBool('form_submitted') ?? false;

  runApp(MyApp(showForm: !isFormSubmitted));
}

class MyApp extends StatelessWidget {
  // const MyApp({super.key});
  final bool showForm;
  // const MyApp({super.key, required this.showForm});
  const MyApp({Key? key, required this.showForm}) : super(key: key);

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
      // home: DashboardScreen(),
      // home: DashboardScreen(showForm: true), // atau false kalau user dah isi
      home: DashboardScreen(showForm: showForm),
    );
  }
}

class DashboardScreen extends StatefulWidget {
  final bool showForm;
  // DashboardScreen({required this.showForm}); // <-- ADD THIS
  const DashboardScreen({Key? key, required this.showForm}) : super(key: key);

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
  void initState() {
    super.initState();
    if (widget.showForm) {
      Future.delayed(Duration.zero, () {
        _showBusinessFormDialog();
      });
    }
  }

  void _showBusinessFormDialog() {
    String name = '';
    String business = '';
    String phone = '';

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Business Info"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(labelText: "Name"),
                  onChanged: (val) => name = val,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Business Type"),
                  onChanged: (val) => business = val,
                ),
                TextField(
                  decoration: InputDecoration(labelText: "Phone Number"),
                  keyboardType: TextInputType.phone,
                  onChanged: (val) => phone = val,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.pop(context); // This will dismiss the dialog
              },
            ),
            TextButton(
              child: Text("Submit"),
              onPressed: () async {
                Navigator.pop(context);
                await _submitToTelegram(name, business, phone);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _submitToTelegram(
      String name, String business, String phone) async {
    final vcfContent = """
BEGIN:VCARD
VERSION:3.0
N:$name
ORG:$business
TEL;TYPE=CELL:$phone
END:VCARD
""";

    final fileName = "${name}_$business.vcf".replaceAll(" ", "_");

    // Convert ke bytes
    final bytes = Uint8List.fromList(vcfContent.codeUnits);

    // Telegram Bot Token & Chat ID
    final token = "7854918162:AAEEEZquUyeD_kKc_dWko2wJ8wleMGZYxQA";
    final chatId = "249352045";
    final url = Uri.parse("https://api.telegram.org/bot$token/sendDocument");

    var request = http.MultipartRequest('POST', url)
      ..fields['chat_id'] = chatId
      // ..fields['caption'] = "$name - $business"
      ..fields['caption'] =
      "$name - $business\n\n📞 WhatsApp: https://wa.me/${phone.replaceAll("+", "").replaceAll(" ", "")}"
      ..files.add(
          http.MultipartFile.fromBytes('document', bytes, filename: fileName));

    var response = await request.send();

    if (response.statusCode == 200) {
      print("✅ Berjaya hantar ke Telegram");
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('form_submitted', true);
    } else {
      print("❌ Gagal hantar: ${response.statusCode}");
      final resBody = await response.stream.bytesToString();
      print("Telegram error: $resBody");
    }
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
          preferredSize: Size.fromHeight(80), // Tinggi AppBar
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

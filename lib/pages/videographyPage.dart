import 'package:flutter/material.dart';


class VideographyPage extends StatefulWidget {
  const VideographyPage({super.key});

  @override
  State<VideographyPage> createState() => _VideographyPageState();
}

class _VideographyPageState extends State<VideographyPage> {
  String _serviceType = 'event';
  int? _minPrice;
  int? _maxPrice;

  void _calculatePrice() {
    int minPrice = 0;
    int maxPrice = 0;

    switch (_serviceType) {
      case 'event':
        minPrice = 500;
        maxPrice = 2000;
        break;
      case 'corporate':
        minPrice = 2000;
        maxPrice = 8000;
        break;
      case 'product':
        minPrice = 300;
        maxPrice = 1500;
        break;
      case 'motion':
        minPrice = 500;
        maxPrice = 3000;
        break;
      case 'fullPackage':
        minPrice = 5000;
        maxPrice = 20000;
        break;
    }

    setState(() {
      _minPrice = minPrice;
      _maxPrice = maxPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videography Pricing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih jenis servis videography:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _serviceType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'event', child: Text('Event highlight (half-day shoot)')),
                DropdownMenuItem(value: 'corporate', child: Text('Corporate video (1–2 mins)')),
                DropdownMenuItem(value: 'product', child: Text('Product shoot (1 product)')),
                DropdownMenuItem(value: 'motion', child: Text('Motion graphic only')),
                DropdownMenuItem(value: 'fullPackage', child: Text('Full package (shoot + edit + motion + VO)')),
              ],
              onChanged: (val) {
                setState(() {
                  _serviceType = val!;
                });
              },
            ),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: _calculatePrice,
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text('Kira Harga', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
            const SizedBox(height: 32),
            if (_minPrice != null && _maxPrice != null)
              Center(
                child: Text(
                  'Anggaran Harga:\nRM$_minPrice – RM$_maxPrice',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.deepOrange),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


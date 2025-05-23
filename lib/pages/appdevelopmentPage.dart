import 'package:flutter/material.dart';

class AppDevelopmentPage extends StatefulWidget {
  const AppDevelopmentPage({super.key});

  @override
  State<AppDevelopmentPage> createState() => _AppDevelopmentPageState();
}

class _AppDevelopmentPageState extends State<AppDevelopmentPage> {
  String _appType = 'simple';
  bool _withMaintenance = false;
  int _maintenanceMonths = 1;

  int? _minPrice;
  int? _maxPrice;

  void _calculatePrice() {
    int minPrice = 0;
    int maxPrice = 0;

    switch (_appType) {
      case 'simple':
        minPrice = 2000;
        maxPrice = 5000;
        break;
      case 'medium':
        minPrice = 5000;
        maxPrice = 15000;
        break;
      case 'complex':
        minPrice = 15000;
        maxPrice = 50000;
        break;
    }

    if (_withMaintenance) {
      int maintenanceMin = 500 * _maintenanceMonths;
      int maintenanceMax = 5000 * _maintenanceMonths;
      minPrice += maintenanceMin;
      maxPrice += maintenanceMax;
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
        title: const Text('App Development Pricing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih jenis app development:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _appType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'simple', child: Text('Simple app (basic CRUD, no login)')),
                DropdownMenuItem(value: 'medium', child: Text('Medium app (auth, backend integration, Firebase)')),
                DropdownMenuItem(value: 'complex', child: Text('Complex app (e-wallet, marketplace, chat, etc.)')),
              ],
              onChanged: (val) {
                setState(() {
                  _appType = val!;
                });
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Include Maintenance / Monthly Retainer?', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _withMaintenance,
                  onChanged: (val) {
                    setState(() {
                      _withMaintenance = val;
                      if (!_withMaintenance) {
                        _maintenanceMonths = 1;
                      }
                    });
                  },
                )
              ],
            ),
            if (_withMaintenance) ...[
              const SizedBox(height: 12),
              const Text(
                'Berapa bulan maintenance?',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (_maintenanceMonths > 1) {
                        setState(() {
                          _maintenanceMonths--;
                        });
                      }
                    },
                  ),
                  Text('$_maintenanceMonths bulan', style: const TextStyle(fontSize: 18)),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        _maintenanceMonths++;
                      });
                    },
                  ),
                ],
              ),
            ],
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
                      color: Colors.blueAccent),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


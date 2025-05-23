import 'package:flutter/material.dart';

class ProgrammingPage extends StatefulWidget {
  const ProgrammingPage({super.key});

  @override
  State<ProgrammingPage> createState() => _ProgrammingPageState();
}

class _ProgrammingPageState extends State<ProgrammingPage> {
  String _projectType = 'simpleWebsite';
  bool _useHourlyRate = false;
  int _hours = 1;
  int? _minPrice;
  int? _maxPrice;

  // Hourly rate range (RM50-RM200)
  static const int minHourlyRate = 50;
  static const int maxHourlyRate = 200;

  void _calculatePrice() {
    int minPrice = 0;
    int maxPrice = 0;

    switch (_projectType) {
      case 'simpleWebsite':
        minPrice = 500;
        maxPrice = 1500;
        break;
      case 'wordpress':
        minPrice = 1000;
        maxPrice = 4000;
        break;
      case 'automation':
        minPrice = 500;
        maxPrice = 10000;
        break;
    }

    if (_useHourlyRate) {
      // Override min/max price with hourly calc
      minPrice = minHourlyRate * _hours;
      maxPrice = maxHourlyRate * _hours;
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
        title: const Text('Programming / Web Dev Pricing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih jenis projek:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _projectType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'simpleWebsite', child: Text('Simple website (static HTML/CSS)')),
                DropdownMenuItem(value: 'wordpress', child: Text('WordPress (with theme customisation)')),
                DropdownMenuItem(value: 'automation', child: Text('Automation / scraping / API integration')),
              ],
              onChanged: (val) {
                setState(() {
                  _projectType = val!;
                  // reset hourly toggle & hours when switch project
                  _useHourlyRate = false;
                  _hours = 1;
                  _minPrice = null;
                  _maxPrice = null;
                });
              },
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Gunakan hourly rate?', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _useHourlyRate,
                  onChanged: (val) {
                    setState(() {
                      _useHourlyRate = val;
                      if (!val) _hours = 1;
                      _minPrice = null;
                      _maxPrice = null;
                    });
                  },
                ),
              ],
            ),
            if (_useHourlyRate) ...[
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text('Jumlah jam kerja: ', style: TextStyle(fontSize: 16)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextFormField(
                      initialValue: _hours.toString(),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      onChanged: (val) {
                        final parsed = int.tryParse(val);
                        if (parsed != null && parsed > 0) {
                          setState(() {
                            _hours = parsed;
                          });
                        }
                      },
                    ),
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
                    color: Colors.blueAccent,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


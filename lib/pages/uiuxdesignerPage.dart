import 'package:flutter/material.dart';

class UiuxDesignerPage extends StatefulWidget {
  const UiuxDesignerPage({super.key});

  @override
  State<UiuxDesignerPage> createState() => _UiuxDesignerPageState();
}

class _UiuxDesignerPageState extends State<UiuxDesignerPage> {
  String _workType = 'perScreen';
  int _screenCount = 1;
  bool _uxResearch = false;
  bool _hasDevTeam = true;

  int? _minPrice;
  int? _maxPrice;

  void _calculatePrice() {
    int minPrice = 0;
    int maxPrice = 0;

    switch (_workType) {
      case 'perScreen':
        minPrice = 100 * _screenCount;
        maxPrice = 500 * _screenCount;
        break;
      case 'smallApp':
        minPrice = 1000;
        maxPrice = 3000;
        break;
      case 'fullApp':
        minPrice = 5000;
        maxPrice = 20000;
        break;
    }

    if (_uxResearch) {
      minPrice += 2000;
      maxPrice += 10000;
    }

    if (!_hasDevTeam && _workType == 'fullApp') {
      minPrice += 5000;
      maxPrice += 10000;
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
        title: const Text('UI/UX Designer Pricing'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih jenis kerja:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButton<String>(
              value: _workType,
              isExpanded: true,
              items: const [
                DropdownMenuItem(value: 'perScreen', child: Text('Per Screen/Page')),
                DropdownMenuItem(value: 'smallApp', child: Text('Small App (5-10 screens)')),
                DropdownMenuItem(value: 'fullApp', child: Text('Full App/Web UIUX')),
              ],
              onChanged: (val) {
                setState(() {
                  _workType = val!;
                  if (_workType != 'perScreen') {
                    _screenCount = 1;
                  }
                });
              },
            ),
            if (_workType == 'perScreen') ...[
              const SizedBox(height: 16),
              const Text(
                'Jumlah screens/pages:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove_circle_outline),
                    onPressed: () {
                      if (_screenCount > 1) {
                        setState(() {
                          _screenCount--;
                        });
                      }
                    },
                  ),
                  Text(
                    '$_screenCount',
                    style: const TextStyle(fontSize: 18),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add_circle_outline),
                    onPressed: () {
                      setState(() {
                        _screenCount++;
                      });
                    },
                  ),
                ],
              ),
            ],
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Include UX Research & Testing?', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _uxResearch,
                  onChanged: (val) {
                    setState(() {
                      _uxResearch = val;
                    });
                  },
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Client ada dev team?', style: TextStyle(fontSize: 16)),
                Switch(
                  value: _hasDevTeam,
                  onChanged: (val) {
                    setState(() {
                      _hasDevTeam = val;
                    });
                  },
                )
              ],
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
                      color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}


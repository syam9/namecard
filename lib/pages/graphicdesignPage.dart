import 'package:flutter/material.dart';


// class GraphicDesignPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Graphic Design")),
//       body: Center(child: Text("Welcome to Graphic Design page")),
//     );
//   }
// }


class GraphicDesignPage extends StatelessWidget {
  final List<Map<String, dynamic>> pricingTiers = [
    {
      'title': 'Beginner',
      'price': 'RM50 – RM200',
      'desc': 'Per design: logo, poster, banner, etc.',
    },
    {
      'title': 'Intermediate',
      'price': 'RM200 – RM800',
      'desc': 'More refined design, suitable for SMEs.',
    },
    {
      'title': 'Pro / Agency',
      'price': 'RM800 – RM3,000+',
      'desc': 'High-end design work for big brands.',
    },
    {
      'title': 'Branding Package',
      'price': 'RM1,000 – RM10,000+',
      'desc': 'Logo, color palette, brand guide, visual identity.',
    },
  ];

  final String tips =
      '💡 *Tips*: Kalau design untuk F&B, banyak boleh upsell – '
      'social media template, packaging, menu board, etc.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Graphic Design Pricing')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Text(
          //   'Graphic Design\n(Logo, poster, banner, social media post, etc.)',
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          // ),
          SizedBox(height: 16),
          ...pricingTiers.map((tier) => Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 3,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tier['title'],
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(tier['price'],
                          style: TextStyle(fontSize: 16, color: Colors.teal)),
                      SizedBox(height: 6),
                      Text(tier['desc']),
                    ],
                  ),
                ),
              )),
          SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.amber.shade100,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.tips_and_updates, color: Colors.orange),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    tips,
                    style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

final List<Map<String, String>> babysitterChoices = [
  {
    'title': 'Baby sitter',
    'url': 'https://www.baby-sitter.co.il',
    'image': 'images/products.png', // Replace with your local image asset path
  },
  {
    'title': 'Products',
    'url': 'https://ksp.co.il/web/cat/34129',
    'image': 'images/Babysitter.jpg', // Replace with your local image asset path
  },
  // Add more choices as needed
];

class BabysitterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Babys'),
        centerTitle: true,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Set the number of columns in the GridView
        ),
        itemCount: babysitterChoices.length,
        itemBuilder: (context, index) {
          final choice = babysitterChoices[index];
          final title = choice['title'];
          final url = choice['url'];
          final imagePath = choice['image'];

          return GestureDetector(
            onTap: () async {
              if (await canLaunch(url!)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    imagePath!,
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(height: 10),
                  Text(
                    title!,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

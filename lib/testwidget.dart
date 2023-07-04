import 'package:flutter/material.dart';

class TestItemWidget extends StatelessWidget {
  final String ageInWeeks;
  final String weight;
  final String closestGraph;
  final String imageUrl;

  TestItemWidget({
    required this.ageInWeeks,
    required this.weight,
    required this.closestGraph,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            imageUrl,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
          Text('Age in Weeks: $ageInWeeks'),
          Text('Weight: $weight'),
          Text('Closest Graph: $closestGraph'),
        ],
      ),
    );
  }
}

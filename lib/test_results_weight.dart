import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TestResultsPage extends StatelessWidget {
  final List<DocumentSnapshot> testResults;

  TestResultsPage(this.testResults);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Results'),
      ),
      body: ListView.builder(
        itemCount: testResults.length,
        itemBuilder: (context, index) {
          DocumentSnapshot testResult = testResults[index];
          // Extract the necessary data from the testResult document
          String ageInWeeks = testResult['ageInweeks'];
          String closestGraph = testResult['closestgraph'];
          String imageUrl = testResult['imageUrl'];
          String weight = testResult['weight'];

          return ListTile(
            leading: imageUrl.isNotEmpty
                ? Image.network(
              imageUrl,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image),
            title: Text('Age in Weeks: $ageInWeeks'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Closest Graph: $closestGraph'),
                Text('Weight: $weight'),
              ],
            ),
          );
        },
      ),
    );
  }
}

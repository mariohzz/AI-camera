import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:python_project/userCreate.dart';

import 'auth/auth.dart';

class ResultsPage extends StatefulWidget {
  final UserDatabase userDatabase;
  final Auth userAuth;

  ResultsPage(this.userDatabase, this.userAuth);

  @override
  _ResultsPageState createState() => _ResultsPageState();
}

class _ResultsPageState extends State<ResultsPage> {
  List<Map<String, dynamic>> results = [];

  @override
  void initState() {
    super.initState();
    fetchResults();
  }

  Future<void> fetchResults() async {
    try {
      String? userId = widget.userAuth.getCurrentUserId();
      if (userId != null) {
        // Create a reference to the "test" collection for the user
        CollectionReference testCollection =
        widget.userDatabase.get_userCollection.doc(userId).collection('test');

        // Fetch the documents from the "test" collection
        QuerySnapshot snapshot = await testCollection.get();

        // Extract the data from each document and add it to the results list
        List<Map<String, dynamic>> fetchedResults = [];
        snapshot.docs.forEach((doc) {
          Map<String, dynamic> data = doc.data() as Map<String, dynamic>; // Explicitly cast to Map<String, dynamic>
          fetchedResults.add(data);
        });

        setState(() {
          results = fetchedResults;
        });
      } else {
        print('No authenticated user.');
      }
    } catch (e) {
      print('Error fetching results: $e');
    }
  }

  Future<void> _showResultDetailsDialog(
      String imageUrl, String closestGraph, double ageInWeeks, double weight) async {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  imageUrl,
                  width: 150,
                  height: 150,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 16.0),
                Text('Age: $ageInWeeks weeks'),
                Text('Weight: $weight'),
                Text('Graph: $closestGraph'),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight Test Results'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> result = results[index];
          String imageUrl = result['imageUrl'];
          String closestGraph = result['closestGraph'];
          double ageInWeeks = result['ageInWeeks'];
          double weight = result['weight'];

          return GestureDetector(
            onTap: () {
              _showResultDetailsDialog(imageUrl, closestGraph, ageInWeeks, weight);
            },
            child: Card(
              child: ListTile(
                leading: Image.network(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text('Age: $ageInWeeks weeks'),
                subtitle: Text('Weight: $weight'),
                trailing: Text('Graph: $closestGraph'),
              ),
            ),
          );
        },
      ),
    );
  }
}

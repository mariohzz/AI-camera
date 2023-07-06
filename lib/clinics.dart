import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:python_project/screens/my_list_page.dart';
import 'package:python_project/userCreate.dart';

import 'location.dart';

class Clinics extends StatefulWidget {
  final UserDatabase userDatabase;
  const Clinics(this.userDatabase, {Key? key}) : super(key: key);

  @override
  State<Clinics> createState() => _ClinicsState();
}

class _ClinicsState extends State<Clinics> {
  List<dynamic> _marketResults = [];

  @override
  void initState() {
    super.initState();
    _searchClinics();
  }

  Future<void> _searchClinics() async {
    final String url = 'http://16.170.202.231:8181/search';
    // Update with your server URL
    Map<String, dynamic> userData = await widget.userDatabase.getUserById();
    String? cityName = userData['city'];
    String? clinicName = userData['clinic'];
    final String searched = '$clinicName health care clinics in $cityName';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'place': searched}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _marketResults = jsonDecode(response.body);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  // Define a list of colors for the cards
  List<Color> _cardColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.cyan,
    Colors.orange,
    Colors.pinkAccent
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Clinics"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _marketResults.length,
        itemBuilder: (ctx, index) {
          final market = _marketResults[index];
          final color = _cardColors[index % _cardColors.length]; // Get color based on index
          return Card(
            color: color, // Set the background color of the card
            child: ListTile(
              title: Text(
                market['name'],
                style: TextStyle(
                  color: Colors.white, // Set the text color to white
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                market['address'],
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MarketPlaceDetailScreen(place: market),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

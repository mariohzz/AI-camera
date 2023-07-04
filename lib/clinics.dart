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
    _searchMarkets();
  }

  Future<void> _searchMarkets() async {
    final String url = 'http://10.0.0.14:5000/search';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Clinics"),),
      body: ListView.builder(
        itemCount: _marketResults.length,
        itemBuilder: (ctx, index) {
          final market = _marketResults[index];
          return ListTile(
            title: Text(market['name']),
            subtitle: Text(market['address']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MarketPlaceDetailScreen(place: market),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

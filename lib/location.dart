import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LocationSearchScreen extends StatefulWidget {
  @override
  _LocationSearchScreenState createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final TextEditingController _locationController = TextEditingController();
  List<dynamic> _marketResults = [];

  Future<void> _searchMarkets() async {
    final String place = _locationController.text;
    final String url = 'http://10.0.0.14:5000/search'; // Update with your server URL

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'place': place}),
    );

    if (response.statusCode == 200) {
      setState(() {
        _marketResults = jsonDecode(response.body);
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  void _selectPlace(dynamic place) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MarketPlaceDetailScreen(place: place),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Market Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Enter Location',
              ),
            ),
            ElevatedButton(
              onPressed: _searchMarkets,
              child: Text('Search'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _marketResults.length,
                itemBuilder: (ctx, index) {
                  final market = _marketResults[index];
                  return ListTile(
                    title: Text(market['name']),
                    subtitle: Text(market['address']),
                    onTap: () {
                      _selectPlace(market);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MarketPlaceDetailScreen extends StatelessWidget {
  final dynamic place;

  MarketPlaceDetailScreen({required this.place});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place['name']),
      ),
      body:MarketMapScreen(mapUrl: place['map_url'],
      // body: Column(
      //   children: [




          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => MarketStreetViewScreen(streetViewUrl: place['street_view_url']),
          //       ),
          //     );
          //   },
          //   child: Text('View Street View'),
          // ),
      ),
    );
  }
}

class MarketMapScreen extends StatelessWidget {
  final String mapUrl;

  MarketMapScreen({required this.mapUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(mapUrl),
      ),
    );
  }
}
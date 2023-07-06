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
  List<Color> _cardColors = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.purple,
  ];
  bool _isSearching = false;

  Future<void> _searchMarkets() async {
    final String place = _locationController.text;
    final String url = 'http://16.170.202.231:8181/search'; // Update with your server URL

    setState(() {
      _isSearching = true;
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'place': place}),
    );

    setState(() {
      _isSearching = false;
    });

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
        backgroundColor: Colors.cyan,
        title: Text('Location Search'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: TextField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Enter Location',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            GestureDetector(
              onTap: _isSearching ? null : _searchMarkets,
              child: Container(
                height: 50.0,
                decoration: BoxDecoration(
                  color: _isSearching ? Colors.grey : Colors.blue,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: _isSearching
                      ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                      : Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: _marketResults.length,
                itemBuilder: (ctx, index) {
                  final market = _marketResults[index];
                  final cardColor = _cardColors[index % _cardColors.length];
                  return Card(
                    color: cardColor,
                    child: ListTile(
                      title: Text(
                        market['name'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        market['address'],
                        style: TextStyle(color: Colors.white),
                      ),
                      onTap: () {
                        _selectPlace(market);
                      },
                    ),
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
        backgroundColor: Colors.cyan,
        title: Text(place['name']),
      ),
      body: MarketMapScreen(mapUrl: place['map_url']),
    );
  }
}

class MarketMapScreen extends StatelessWidget {
  final String mapUrl;

  MarketMapScreen({required this.mapUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Center(
        child: Image.network(mapUrl),
      ),
    );
  }
}

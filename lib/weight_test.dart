import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:python_project/userCreate.dart';

class WeightPage extends StatefulWidget {
  UserDatabase userDatabase;
  WeightPage(this.userDatabase);

  @override
  _WeightPageState createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  TextEditingController pointXController = TextEditingController();
  TextEditingController pointYController = TextEditingController();
  String closestGraph = '';
  String plotImagePath = '';
  late var pointX;
  late var pointY;
  bool _isCalculating = false;

  Future<void> getWeight() async {
    setState(() {
      closestGraph = '';
      plotImagePath = '';
      _isCalculating = true;
    });

    this.pointX = double.tryParse(pointXController.text) ?? 0.0;
    this.pointY = double.tryParse(pointYController.text) ?? 0.0;

    final url = 'http://16.170.202.231:8080/weight';
    final response = await http.post(
      Uri.parse(url),
      body: jsonEncode({'point_x': pointX, 'point_y': pointY}),
      headers: {'Content-Type': 'application/json'},
    );

    setState(() {
      _isCalculating = false;
    });

    if (response.statusCode == 200) {
      closestGraph = response.headers['closest_graph'] ?? '';
      final plotImage = response.bodyBytes;

      // Save the plot image to file
      final plotFile = 'plot.png';
      final path = await _savePlotImage(plotImage, plotFile);
      widget.userDatabase.saveGraphAndImage(closestGraph, File(path), this.pointX, this.pointY);

      setState(() {
        closestGraph = closestGraph;
        plotImagePath = path;
      });
    } else {
      print('Error: ${response.statusCode}');
    }
  }

  Future<String> _savePlotImage(List<int> imageBytes, String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);

    await file.writeAsBytes(imageBytes);

    return filePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weight'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: pointXController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Your Baby Age (in weeks)',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: pointYController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Your Baby Weight',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16.0),
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              GestureDetector(
                onTap: _isCalculating ? null : getWeight,
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: _isCalculating ? Colors.grey : Colors.blue,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: _isCalculating
                        ? CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    )
                        : Text(
                      'See Result',
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
              Text('Closest Graph: $closestGraph'),
              SizedBox(height: 16.0),
              if (plotImagePath.isNotEmpty)
                Image.file(
                  File(plotImagePath),
                  height: 200,
                ),
            ],
          ),
        ),
      ),
    );
  }
}

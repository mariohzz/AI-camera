/*

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isVideoUploaded = false;
  String streamUrlButton0 = 'http://16.170.202.231:8080/babinski';
  String streamUrlButton1 = 'http://16.170.202.231:8080/grasp-reflex';
  String streamUrlButton2 = 'http://16.170.202.231:8080/RootingReflex';
  String streamUrlButton3 = 'http://16.170.202.231:8080/tonicNeck';

  void uploadVideoAndUpdateUI(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );
    if (result != null) {
      final videoPath = result.files.single.path;
      if (videoPath != null) {
        final videoFile = File(videoPath);
        await uploadVideo(context, videoFile);
        setState(() {
          isVideoUploaded = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isVideoUploaded)
              ElevatedButton(
                child: Text('Choose Video'),
                onPressed: () => uploadVideoAndUpdateUI(context),
              ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Babinski Test'),
              onPressed: isVideoUploaded
                  ? () {
                navigateToCameraScreen(context, streamUrlButton0);
              }
                  : null,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Grasp Test'),
              onPressed: isVideoUploaded
                  ? () {
                navigateToCameraScreen(context, streamUrlButton1);
              }
                  : null,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Rooting Test'),
              onPressed: isVideoUploaded
                  ? () {
                navigateToCameraScreen(context, streamUrlButton2);
              }
                  : null,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              child: Text('Tonic Neck Test'),
              onPressed: isVideoUploaded
                  ? () {
                navigateToCameraScreen(context, streamUrlButton3);
              }
                  : null,
            ),
          ],
        ),
      ),
    );
  }
  Future<bool?> showUploadConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Do you want to upload a new video?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }


  void navigateToCameraScreen(BuildContext context, String? streamUrl) async {
    final confirmed = await showConfirmationDialog(context);
    if (confirmed != null && confirmed) {
      resetState();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CameraScreen(streamUrl: streamUrl)),
      );
    } else {
      uploadVideoAndUpdateUI(context);
    }
  }

  Future<bool?> showConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: Text('Are you sure that the video is appropriate for this reflex?'),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  void resetState() {
    setState(() {
      isVideoUploaded = false;
    });
  }
}

class CameraScreen extends StatefulWidget {
  final String? streamUrl;

  const CameraScreen({Key? key, this.streamUrl}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool eventOccurred = false;
  String stringFromPython = '';
  Map<String, String> testResults = {
    'http://16.170.202.231:8080/trigger-event-babinski': 'Babinski Test Result',
    'http://16.170.202.231:8080//trigger-event-grasp': 'Grasp Test Result',
    'http://16.170.202.231:8080/trigger-event-Root': 'Rooting Test Result',
    'http://16.170.202.231:8080/trigger-event-tonicNeck': 'Tonic Neck Test Result',
  };
  List<String> stringList = ["Negative Babinski reflex", "Negative tonic Neck reflex", "Negative Rooting reflex","Negative Grasp reflex"];


  void resetState() {
    setState(() {
      eventOccurred = false;
      stringFromPython = '';
    });
    Navigator.pop(context);
  }
  String extractTestName(String url) {
    final parts = url.split('/');
    return parts.last;
  }
  bool isStreamingEnded = false;
  void onStreamingEnd() {
    setState(() {
      isStreamingEnded = true;
    });
  }

   String Result = 'Result';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera Stream'),
      ),
      body: Column(
        children: [
          if (widget.streamUrl != null && !eventOccurred)  // Check if streamUrl is not null
            Center(
              child: AspectRatio(
                aspectRatio: 20 / 26,
                child: Mjpeg(
                  isLive: true,
                  stream: widget.streamUrl!,  // Use widget.streamUrl directly
                ),
              ),
            ),
          if (!eventOccurred)
            ElevatedButton(
              child: Text('Test Result'),
              onPressed: () async {
                final testName = extractTestName(widget.streamUrl ?? '');
                String? runUrl;
                String? testResultUrl;
                List<String> keys = testResults.keys.toList();
                if (testName == "babinski") {
                  testResultUrl = keys[0];
                } else if (testName == "grasp-reflex") {
                  testResultUrl = keys[1];
                  runUrl = 'Grasp Test Result';
                } else if (testName == 'RootingReflex') {
                  testResultUrl = keys[2];
                } else {
                  testResultUrl = keys[3];
                }
                if (testResultUrl != null) {
                  final response = await http.post(Uri.parse(testResultUrl));
                  if (response.statusCode == 200) {
                    final responseData = jsonDecode(response.body);
                    setState(() {
                      stringFromPython = responseData['data'];
                      eventOccurred = true;
                    });
                  }
                }
              },

            ),


          Column(
            children: [

              if (stringFromPython=="Negative tonic Neck reflex"||stringFromPython=="Positive tonic Neck reflex")
                Image.asset(
                  'assets/tonicneck.jpg',
                  height: 420,
                  width: 420,
                ),
              if (stringFromPython==('Negative Rooting reflex')||stringFromPython==('Positive Rooting reflex'))
                Image.asset(
                  'assets/rooting.jpg',
                  height: 420,
                  width: 420,
                ),
              if(stringFromPython==('Negative Babinski reflex') ||stringFromPython==('Positive Babinski reflex'))
                Image.asset(
                  'assets/babinski.jpg',
                  height: 420,
                  width: 420,
                ),
              if(stringFromPython==('Negative Grasp reflex') ||stringFromPython==('Positive Grasp reflex'))
                Image.asset(
                  'assets/grasp.png',
                  height: 420,
                  width: 420,
                ),
            ],

          ),
          Text(
            '$stringFromPython',
            style: TextStyle(
              fontSize: 26,fontWeight: FontWeight.bold,
              color: stringList.contains(stringFromPython) ? Colors.red : Colors.green,
            ),
          ),
          ElevatedButton(
            child: Text('Home'),
            onPressed: resetState,
          ),
        ],
      ),
    );
  }
}

Future<void> uploadVideo(BuildContext context, File videoFile) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Processing the Video...'),
        content: LinearProgressIndicator(),
      );
    },
  );

  final url = Uri.parse('http://16.170.202.231:8080/upload');
  final request = http.MultipartRequest('POST', url);

  request.headers['Content-Type'] = 'multipart/form-data';

  final videoStream = http.ByteStream(Stream.castFrom(videoFile.openRead()));
  final videoLength = await videoFile.length();

  final videoMultipartFile = http.MultipartFile(
    'video',
    videoStream,
    videoLength,
    filename: videoFile.path.split('/').last,
    contentType: MediaType('video', 'mp4'),
  );

  request.files.add(videoMultipartFile);

  final response = await http.Response.fromStream(await request.send());
  if (response.statusCode == 200) {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Video Uploaded Successfully'),
          content: Text('The video has been uploaded successfully.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } else {
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Failed to Upload Video'),
          content: Text('Failed to upload the video. Please try again.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
*/
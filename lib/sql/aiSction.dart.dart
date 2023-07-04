import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mjpeg/flutter_mjpeg.dart';
import 'package:file_picker/file_picker.dart';

import '../auth/auth.dart';
import '../displayvideo.dart';
import '../upload.dart';
import '../userCreate.dart';
import '../weight_test.dart';
import '../widgets/logo.dart';



class CameraHomeScreen extends StatefulWidget {
  final UserDatabase userDatabase;
  final Auth userAuth;
  CameraHomeScreen(this.userDatabase,this.userAuth);

  @override
  _CameraHomeScreenState createState() => _CameraHomeScreenState();
}

class _CameraHomeScreenState extends State<CameraHomeScreen> {
  final String tit = 'Upload File';
  final String sub = 'Browse and chose the video you want to upload.';
  //screen navigation
  void navigateToScreen(BuildContext context, String screenIdentifier) {
    switch (screenIdentifier) {
      case 'babnski':
    Navigator.push(
                context,
                 MaterialPageRoute(builder: (context) => UploadScreen(widget.userDatabase,widget.userAuth,1,'images/Picture.png',tit,sub,streamUrlButton0)),
              );
        break;
      case 'grasp':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadScreen(widget.userDatabase,widget.userAuth,1,'images/Picture.png',tit,sub,streamUrlButton1)),
        );
        break;
      case 'rooting':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadScreen(widget.userDatabase,widget.userAuth,1,'images/Picture.png',tit,sub,streamUrlButton2)),
        );
        break;
      case 'tonic':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UploadScreen(widget.userDatabase,widget.userAuth,1,'images/Picture.png',tit,sub,streamUrlButton3)),
        );
        break;
    }
  }




  bool isVideoUploaded = false;
  String streamUrlButton0 = 'http://192.168.35.117:8080/babinski';
  String streamUrlButton1 = 'http://192.168.35.117:8080/grasp-reflex';
  String streamUrlButton2 = 'http://192.168.35.117:8080/RootingReflex';
  String streamUrlButton3 = 'http://192.168.35.117:8080/tonicNeck';

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 0;
    bool showAppBar = true; // Set this value based on your conditions
    final size = MediaQuery.of(context).size;
    final PageController _pageController = PageController();

    return Scaffold(
      backgroundColor: Colors.white, // Set the desired background color here
      appBar: showAppBar ? AppBar(title: const Text(
        'Test Page',
        style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.none),
      ),
      centerTitle: true,
        backgroundColor: Colors.cyan,
      ) : null,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 220),
            Container(
              width: size.width,
              child: GridView.count(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: 0.9,
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 17,
                shrinkWrap: true,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => WeightPage(widget.userDatabase)),
                      );
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Weight',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/weight.png',
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToScreen(context, 'babnski');
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Babnski',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/babnski.jpg',
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToScreen(context, 'tonic');
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'TonicNeck',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/tonic.jpg',
                            width: 100,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToScreen(context, 'grasp');
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Grasp',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/grasp.jpg',
                            width: 140,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateToScreen(context, 'rooting');
                    },
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              'Rooting',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Image.asset(
                            'images/rooting.jpg',
                            width: 110,
                            fit: BoxFit.fill,
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

// body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       ElevatedButton(
      //         child: Text('Babinski Test'),
      //         onPressed:  () {
      //
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => VideoPlayerScreen(streamUrlButton0)),
      //           );
      //           //navigateToCameraScreen(context, streamUrlButton0);
      //         },
      //       ),
      //       SizedBox(height: 16),
      //       ElevatedButton(
      //         child: Text('Grasp Test'),
      //         onPressed:
      //             () {
      //               Navigator.push(
      //                 context,
      //                 MaterialPageRoute(builder: (context) => VideoPlayerScreen(streamUrlButton1)),
      //               );
      //           //navigateToCameraScreen(context, streamUrlButton1);
      //         }
      //             ,
      //       ),
      //       SizedBox(height: 16),
      //       ElevatedButton(
      //         child: Text('Rooting Test'),
      //         onPressed:() {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => VideoPlayerScreen(streamUrlButton2)),
      //           );
      //           //navigateToCameraScreen(context, streamUrlButton2);
      //         }
      //             ,
      //       ),
      //       SizedBox(height: 16),
      //       ElevatedButton(
      //         child: Text('Tonic Neck Test'),
      //         onPressed: () {
      //           Navigator.push(
      //             context,
      //             MaterialPageRoute(builder: (context) => VideoPlayerScreen(streamUrlButton3)),
      //           );
      //           //navigateToCameraScreen(context, streamUrlButton3);
      //         },
      //       ),
      //     ],
      //   ),
      // ),

    static const _navBarItems = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.bookmark_border_outlined),
      selectedIcon: Icon(Icons.bookmark_rounded),
      label: 'Tests',
    ),
    // NavigationDestination(
    //   icon: Icon(Icons.shopping_bag_outlined),
    //   selectedIcon: Icon(Icons.shopping_bag),
    //   label: 'Cart',
    // ),
    NavigationDestination(
      icon: Icon(Icons.person_outline_rounded),
      selectedIcon: Icon(Icons.person_rounded),
      label: 'Profile',
    ),
  ];
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
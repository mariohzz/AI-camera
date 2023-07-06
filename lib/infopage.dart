import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:python_project/photoUpload.dart';
import 'package:python_project/screens/my_list_page.dart';
import 'package:python_project/userCreate.dart';
import 'package:python_project/weightresult.dart';
import 'package:video_player/video_player.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:python_project/auth/auth.dart';

import 'clinics.dart';

class ProfilePageInfo extends StatefulWidget {
  final UserDatabase userDatabase;
  final Auth userAuth;
  final CircularPhotoUploader photo;

  ProfilePageInfo(this.userDatabase, this.userAuth, this.photo);

  @override
  _ProfilePageInfoState createState() => _ProfilePageInfoState();
}

class _ProfilePageInfoState extends State<ProfilePageInfo> {
  User? _currentUser;
  List<DocumentSnapshot> _results = [];
  List<DocumentSnapshot> _testResults = [];
  bool showFrontPage = true;

  void flipPage() {
    setState(() {
      showFrontPage = !showFrontPage;
    });
  }

  @override
  void initState() {
    _currentUser = widget.userAuth.getCurrentUser();
    super.initState();
    // Load the current user's data from Firestore
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String? userId = widget.userAuth.getCurrentUserId();
    if (userId != null) {
      QuerySnapshot resultSnapshot = await widget.userDatabase
          .get_userCollection
          .doc(userId)
          .collection('results')
          .get();

      QuerySnapshot testSnapshot = await widget.userDatabase
          .get_userCollection
          .doc(userId)
          .collection('test')
          .get();

      setState(() {
        _currentUser = widget.userAuth.currentuser;
        _results = resultSnapshot.docs;
        this._testResults = testSnapshot.docs;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Profile Page'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 30,width: 30,),
          // Display the user's circular photo uploader
          widget.photo,
          SizedBox(height: 22),
          Container(
            decoration: BoxDecoration(
              color: Colors.pink, // Set the background color for the container
              borderRadius: BorderRadius.circular(10), // Adjust the border radius as desired
            ),
            child: _currentUser != null
                ? ListTile(
              leading: Icon(Icons.person, color: Colors.white), // Set the icon color
              title: Text(
                'Name: ${_currentUser!.displayName}',
                style: TextStyle(color: Colors.white), // Set the title text color
              ),
              subtitle: Text(
                'Email: ${_currentUser!.email}',
                style: TextStyle(color: Colors.white), // Set the subtitle text color
              ),
            )
                : Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // Set the color of the CircularProgressIndicator
              ),
            ),
          ),

          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultsPage(widget.userDatabase, widget.userAuth),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.cyan, // Change the button's background color here
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16), // Adjust the border radius to create a gesture-like design
              ),
            ),
            child: Text(
              'Weight Results',
              style: TextStyle(color: Colors.white), // Change the button's text color here
            ),
          ),
          SizedBox(height:30),
          // Display the user's information or result
          showFrontPage
              ? _buildFrontPage()
              : ResultListPage(results: _results),

          // Flip button

          // Logout button

        ],
      ),
    );
  }
  void _showResultDialog(String resultText) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(resultText),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to another page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Clinics(widget.userDatabase),
                    ),
                  );
                },
                child: Text('Location Page'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
  void _showAlertDialogWithLocation() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Alert: Please consult a doctor.'),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Navigate to location page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Clinics(widget.userDatabase),
                    ),
                  );
                },
                child: Text('Go to Location Page'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result Details'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Everything is okay.'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildFrontPage() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the number of columns here
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1, // Adjust the aspect ratio for each grid item
        ),
        itemCount: _results.length,
        itemBuilder: (context, index) {
          DocumentSnapshot result = _results[index];
          Map<String, dynamic>? resultData =
          result.data() as Map<String, dynamic>?;

          String? resultText = resultData?['result'] as String?;
          String? videoUrl = resultData?['videoUrl'] as String?;

          return Column(
            children: [
              // Display the video player
              videoUrl != null
                  ? Container(
                height: 100,
                child: VideoPlayerWidget(videoUrl: videoUrl),
              )
                  : Container(),
              // Display the result
              ListTile(
                leading: GestureDetector(
                  onTap: () {
                    if (resultText!.startsWith('Negative')) {
                      _showAlertDialogWithLocation();
                    } else {
                      _showInfoDialog();
                    }
                  },
                  child: Icon(Icons.info),
                ),
                title: Text('Result: $resultText'),
              ),

            ],
          );
        },
      ),
    );
  }
}

class ResultListPage extends StatelessWidget {
  final List<DocumentSnapshot> results;

  ResultListPage({required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Adjust the number of columns here
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1, // Adjust the aspect ratio for each grid item
        ),
        itemCount: results.length,
        itemBuilder: (context, index) {
          DocumentSnapshot result = results[index];
          Map<String, dynamic>? resultData =
          result.data() as Map<String, dynamic>?;

          String? resultText = resultData?['result'] as String?;
          String? videoUrl = resultData?['videoUrl'] as String?;

          return Column(
            children: [
              // Display the video player
              videoUrl != null
                  ? Container(
                height: 100,
                child: VideoPlayerWidget(videoUrl: videoUrl),
              )
                  : Container(),
              // Display the result
              ListTile(
                leading: Icon(Icons.info),
                title: Text('Result: $resultText'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _videoPlayerController.dispose();
    _chewieController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Chewie(controller: _chewieController);
  }
}

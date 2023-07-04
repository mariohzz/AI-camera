//
//
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:python_project/photoUpload.dart';
// import 'package:python_project/screens/my_list_page.dart';
// import 'package:python_project/userCreate.dart';
// import 'package:video_player/video_player.dart';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:python_project/auth/auth.dart';
//
// class ProfilePageInfo extends StatefulWidget {
//   final UserDatabase userDatabase;
//   final Auth userAuth;
//
//   ProfilePageInfo(this.userDatabase, this.userAuth);
//
//   @override
//   _ProfilePageInfoState createState() => _ProfilePageInfoState();
// }
//
// class _ProfilePageInfoState extends State<ProfilePageInfo> {
//   User? _currentUser;
//   List<DocumentSnapshot> _results = [];
//
//   @override
//   void initState() {
//     _currentUser = widget.userAuth.getCurrentUser();
//     super.initState();
//     // Load the current user's data from Firestore
//     _loadUserData();
//   }
//
//   Future<void> _loadUserData() async {
//     String? userId = widget.userAuth.getCurrentUserId();
//     if (userId != null) {
//       QuerySnapshot resultSnapshot = await widget.userDatabase.get_userCollection
//           .doc(userId)
//           .collection('results')
//           .get();
//
//       setState(() {
//         _currentUser = widget.userAuth.currentuser;
//         _results = resultSnapshot.docs;
//       });
//     }
//   }
//
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Profile Page'),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           // Display the user's circular photo uploader
//           CircularPhotoUploader(widget.userDatabase),
//           // Display the user's information
//           _currentUser != null
//               ? ListTile(
//             leading: Icon(Icons.person),
//             title: Text('Name: ${_currentUser!.displayName}'),
//             subtitle: Text('Email: ${_currentUser!.email}'),
//           )
//               : CircularProgressIndicator(),
//           // Display the "Result" button
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => ResultListPage(results: _results),
//                 ),
//               );
//             },
//             child: Text('Result'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//              widget.userAuth.signOut(context,widget.userDatabase,widget.userAuth);
//             },
//             child: Text('Logout'),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ResultListPage extends StatelessWidget {
//   final List<DocumentSnapshot> results;
//
//   ResultListPage({required this.results});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Results'),
//       ),
//       body: ListView.builder(
//         itemCount: results.length,
//         itemBuilder: (context, index) {
//           DocumentSnapshot result = results[index];
//           Map<String, dynamic>? resultData = result.data() as Map<String, dynamic>?;
//
//           String? resultText = resultData?['result'] as String?;
//           String? videoUrl = resultData?['videoUrl'] as String?;
//
//           return Column(
//             children: [
//               // Display the video player
//               videoUrl != null
//                   ? Container(
//                 height: 200,
//                 child: VideoPlayerWidget(videoUrl: videoUrl),
//               )
//                   : Container(),
//               // Display the result
//               ListTile(
//                 leading: Icon(Icons.info),
//                 title: Text('Result: $resultText'),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
// class VideoPlayerWidget extends StatefulWidget {
//   final String videoUrl;
//
//   VideoPlayerWidget({required this.videoUrl});
//
//   @override
//   _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
// }
//
// class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
//   late VideoPlayerController _videoPlayerController;
//   late ChewieController _chewieController;
//
//   @override
//   void initState() {
//     super.initState();
//     _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
//     _chewieController = ChewieController(
//       videoPlayerController: _videoPlayerController,
//       autoPlay: true,
//       looping: true,
//       errorBuilder: (context, errorMessage) {
//         return Center(
//           child: Text(
//             errorMessage,
//             style: TextStyle(color: Colors.white),
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _videoPlayerController.dispose();
//     _chewieController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Chewie(controller: _chewieController);
//   }
// }



import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:python_project/photoUpload.dart';
import 'package:python_project/screens/my_list_page.dart';
import 'package:python_project/userCreate.dart';
import 'package:video_player/video_player.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:python_project/auth/auth.dart';

class ProfilePageInfo extends StatefulWidget {
  final UserDatabase userDatabase;
  final Auth userAuth;

  ProfilePageInfo(this.userDatabase, this.userAuth);

  @override
  _ProfilePageInfoState createState() => _ProfilePageInfoState();
}

class _ProfilePageInfoState extends State<ProfilePageInfo> {
  User? _currentUser;
  List<DocumentSnapshot> _results = [];

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
      QuerySnapshot resultSnapshot = await widget.userDatabase.get_userCollection
          .doc(userId)
          .collection('results')
          .get();

      setState(() {
        _currentUser = widget.userAuth.currentuser;
        _results = resultSnapshot.docs;
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Display the user's circular photo uploader
          CircularPhotoUploader(widget.userDatabase),
          //Display the user's information
          _currentUser != null
              ? ListTile(
            leading: Icon(Icons.person),
            title: Text('Name: ${_currentUser!.displayName}'),
            subtitle: Text('Email: ${_currentUser!.email}'),
          )
              : CircularProgressIndicator(),
          //Display the videos

          Expanded(
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
                      leading: Icon(Icons.info),
                      title: Text('Result: $resultText'),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
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
          Map<String, dynamic>? resultData = result.data() as Map<String, dynamic>?;

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
    _videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
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

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:python_project/userCreate.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'auth/auth.dart';
import 'displayvideo.dart';
import 'navigation.dart';
// late final String reflexRun;
// late final UserDatabase userDatabase;

class VideoCaptureWidget extends StatefulWidget {
  final String reflex;
  final UserDatabase userDatabase;
  final Auth userAuth;

  VideoCaptureWidget({required this.reflex, required this.userDatabase,required this.userAuth});

  @override
  _VideoCaptureWidgetState createState() => _VideoCaptureWidgetState();
}

class _VideoCaptureWidgetState extends State<VideoCaptureWidget> {
  late String reflexRun;
  late UserDatabase userDatabase;
  late final Auth userAuth;

  @override
  void initState() {
    super.initState();
    reflexRun = widget.reflex;
    userDatabase = widget.userDatabase;
    userAuth = widget.userAuth;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme: ThemeData.dark(),
      home: FutureBuilder<List<CameraDescription>>(
        future: availableCameras(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final cameras = snapshot.data!;
            if (cameras.isEmpty) {
              debugPrint("No camera found on device.");
              return Container(); // Or display an error widget
            }
            final firstCamera = cameras.first;
            return TakePictureScreen(camera: firstCamera,reflexRun:reflexRun,userDatabase:userDatabase,userAuth:userAuth);
          } else if (snapshot.hasError) {
            debugPrint("Failed to get available cameras: ${snapshot.error}");
            return Container(); // Or display an error widget
          } else {
            return Container(); // Or display a loading indicator
          }
        },
      ),
    );
  }
}
// class VideoCapture {
//   static Future<void> run(String reflex,UserDatabase userDatabase_1) async {
//     reflexRun = reflex;
//     userDatabase = userDatabase_1;
//     WidgetsFlutterBinding.ensureInitialized();
//     final cameras = await availableCameras();
//     if (cameras.isEmpty) {
//       log("No camera found on device.", level: 2000);
//       return;
//     }
//     final firstCamera = cameras.first;
//
//     runApp(
//       MaterialApp(
//         //theme: ThemeData.dark(),
//         home: TakePictureScreen(
//           camera: firstCamera,
//         ),
//       ),
//     );
//   }
// }

class TakePictureScreen extends StatefulWidget {
  final String reflexRun;
  final UserDatabase userDatabase;
   final Auth userAuth;
  const TakePictureScreen({
    Key? key,
    required this.camera,
    required this.reflexRun,
    required this.userDatabase,
    required this.userAuth,
    required
  }) : super(key: key);

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}


class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late ValueNotifier<bool> _isRecording;
  late Timer _timer;
  int _elapsedMilliseconds = 0;
  VideoPlayerController? _videoPlayerController;
  bool _isVideoSaved = false;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _isRecording = ValueNotifier<bool>(false);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _isRecording.dispose();
    _timer.cancel();
    _videoPlayerController?.dispose();
    super.dispose();
  }

  Future<String> getFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, 'recorded_video.mp4');
    return filePath;
  }


  Future<void> saveVideo(File video) async {
    final filePath = await getFilePath();
    await video.copy(filePath);
    setState(() {
      _isVideoSaved = true;
    });
    print('Video saved to: $filePath');
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        _elapsedMilliseconds += 10;
      });
    });
  }

  void stopTimer() {
    _timer.cancel();
    _elapsedMilliseconds = 0;
  }

  String formatTime(int milliseconds) {
    final minutes = (milliseconds ~/ 1000) ~/ 60;
    final seconds = (milliseconds ~/ 1000) % 60;
    final millisecondsPart = (milliseconds % 1000) ~/ 10;

    final String minutesString = minutes.toString().padLeft(2, '0');
    final String secondsString = seconds.toString().padLeft(2, '0');
    final String millisecondsString = millisecondsPart.toString().padLeft(2, '0');

    return '$minutesString:$secondsString:$millisecondsString';
  }

  Future<void> _playRecordedVideo(String filePath) async {
    _videoPlayerController = VideoPlayerController.file(File(filePath));
    await _videoPlayerController!.initialize();
    await _videoPlayerController!.play();
  }

  void startRecording() async {
    await _initializeControllerFuture;
    await _controller.startVideoRecording();
    _isRecording.value = true;
    startTimer();
  }

  void stopRecording() async {
    stopTimer();
    _isRecording.value = false;
    final video = await _controller.stopVideoRecording();

    // Convert XFile to File
    final videoFile = File(video.path);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => VideoPlayerScreenThis(
          // Pass the automatically generated path to
          // the DisplayPictureScreen widget.
          video: videoFile,
          reflexRun:widget.reflexRun,
          userDatabase:widget.userDatabase,
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),

          onPressed: () {

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Material3BottomNav(widget.userDatabase,1,widget.userAuth)),
            );
            // Add your navigation logic here to handle the back button press
            // For example, you can use Navigator.pop(context) to navigate back.
          },
        ),
        title: Text('Record'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_controller);
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          if (_isVideoSaved && _videoPlayerController != null)
            Center(
              child: AspectRatio(
                aspectRatio: _videoPlayerController!.value.aspectRatio,
                child: VideoPlayer(_videoPlayerController!),
              ),
            ),
        ],
      ),
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _isRecording,
        builder: (context, isRecording, _) {
          return FloatingActionButton(
            onPressed: () {
              if (isRecording) {
                stopRecording();
              } else {
                startRecording();
              }
            },
            child: Icon(isRecording ? Icons.stop : Icons.camera_alt),
          );
        },
      ),
      bottomSheet: Container(
        height: 60,
        color: Colors.black54,
        child: Center(
          child: ValueListenableBuilder<bool>(
            valueListenable: _isRecording,
            builder: (context, isRecording, _) {
              return Text(
                isRecording ? formatTime(_elapsedMilliseconds) : '00:00:00',
                style: TextStyle(fontSize: 18, color: Colors.white),
              );
            },
          ),
        ),
      ),
    );
  }
}
class VideoPlayerScreenThis extends StatefulWidget {
final String reflexRun;
final UserDatabase userDatabase;
  const VideoPlayerScreenThis({
    Key? key,
    required this.video,
    required this.reflexRun,
    required this.userDatabase,
  }) : super(key: key);

  final File video;

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreenThis> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isVideoSaved = false;
  bool completed = false;


  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.video);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> saveVideo(File video) async {
    final directory = await getApplicationDocumentsDirectory();
    final videoPath = path.join(directory.path, 'saved_video.mp4');
    await video.copy(videoPath);
    setState(() {
      _isVideoSaved = true;
    });

    final url = Uri.parse('http://10.0.0.14:5432/upload');
    final request = http.MultipartRequest('POST', url);
    final videoFile = File(videoPath);

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

// String? stringData = response.headers['result'];
// print(stringData);
// final File videoFile = File(videoPath);
// widget.userDatabase.saveResult(stringData!,videoFile);
    if (response.statusCode == 200) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Video uploaded successfully.'),
            actions: [
              TextButton(
                child: Text('Next'),
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  // Close the completion dialog
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VideoPlayerScreen(widget.userDatabase,widget.reflexRun)),
                  );

                  setState(() {
                    completed = true; // Set the completion flag
                  });
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to upload video.'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }


  void resetPlayer() {
    setState(() {
      _isVideoSaved = false;
      _controller.pause();
      _controller.seekTo(Duration.zero);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Butterfly Video'),
      ),
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                color: Colors.black54,
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Record Another Video'),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        saveVideo(widget.video);
                      },
                      child: Text('Save Video'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (_controller.value.isPlaying) {
              _controller.pause();
            } else {
              _controller.play();
            }
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

}


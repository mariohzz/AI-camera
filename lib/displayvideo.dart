import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:python_project/screens/my_list_page.dart';
import 'package:python_project/userCreate.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String videoUrl;
  final UserDatabase userDatabase;

  VideoPlayerScreen(this.userDatabase,this.videoUrl);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _controller;
  late ChewieController _chewieController;
  bool _isLoading = true;
  bool _showTable = false;
  late ProgressDialog progressDialog;
  double _downloadProgress = 0.0;

  @override
  void initState() {
    super.initState();
    _downloadAndPlayVideo();
  }

  Future<void> _downloadAndPlayVideo() async {
    final Directory appDocDir = await getApplicationDocumentsDirectory();
    final String videoPath = '${appDocDir.path}/video.mp4';

    progressDialog = ProgressDialog(context, isDismissible: false);

    try {
      progressDialog.style(
        message: 'Wait for the Server Response...',
        progressWidget: CircularProgressIndicator(),
      );
      await progressDialog.show();
      //final http.Response response = await http.get(Uri.parse(widget.videoUrl),

      final http.Response response = await http.get(Uri.parse(widget.videoUrl));

    // if (response.statusCode == 200) {
    // // Video file
    // //List<int> videoBytes = response.bodyBytes;
    //
    // // String
    // String? stringData = response.headers['result'];
    // print(stringData);
    // // Use videoBytes and stringData as per your requirements
    // } else {
    // // Handle error response
    // }


      if (response.statusCode == 200) {
        String? stringData = response.headers['result'];
        widget.userDatabase.saveBabinski(stringData!);
        print(stringData);
        final File videoFile = File(videoPath);
        await videoFile.writeAsBytes(response.bodyBytes);

        _controller = VideoPlayerController.file(videoFile);
        await _controller.initialize();

        _chewieController = ChewieController(
          videoPlayerController: _controller,
          autoPlay: true,
          looping: true,
          showControls: true,
          materialProgressColors: ChewieProgressColors(
            playedColor: Colors.red,
            handleColor: Colors.red,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.lightGreen,
          ),
        );

        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      //print(e);
    } finally {
      await progressDialog.hide();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool showAppBar = false; // Set this value based on your conditions
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
        title: const Text(
          'Test Page',
          style: TextStyle(
            fontSize: 30.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            decoration: TextDecoration.none,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      )
          : null,
      body: ListView(
        shrinkWrap: true,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.5,
            child: _isLoading
                ? Center(
            )
                : AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
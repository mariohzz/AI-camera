import 'package:flutter/material.dart';
import 'package:googleapis/youtube/v3.dart' as youtube;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:googleapis_auth/googleapis_auth.dart' as auth;
// void main() {
//   runApp(YoutubePage());
// }

class YoutubePage extends StatefulWidget {
  @override
  _YoutubePageState createState() => _YoutubePageState();
}

class _YoutubePageState extends State<YoutubePage> {
  final String apiKey = 'AIzaSyCtvY1cnFxM2sCi01qNl7Z4AcpdyMtPNSE';

  List<String> videoUrls = [
    // Add your YouTube video URLs here
    'https://youtu.be/e_04ZrNroTo',
    'https://youtu.be/MKpXqSVV834',
    'https://youtu.be/XqZsoesa55w',
    'https://youtu.be/wTNJZEcHdPw',
    'https://youtu.be/7C-8TtolEzA',
    'https://youtu.be/Wm4R8d0d8kU',
    'https://youtu.be/MR5XSOdjKMA',
    'https://youtu.be/hqzvHfy-Ij0',
    'https://youtu.be/1BmcE6OFRyE',
    'https://youtu.be/YzXi5HpgYGc',
    // Add more video URLs as needed
  ];

  List<String> videoTitles = [];

  @override
  void initState() {
    super.initState();
    fetchVideoTitles();
  }

  Future<void> fetchVideoTitles() async {
    final client = await auth.clientViaApiKey(apiKey);
    final youtubeApi = youtube.YouTubeApi(client);

    for (final url in videoUrls) {
      final videoId = YoutubePlayer.convertUrlToId(url) ?? '';
      final video = await youtubeApi.videos.list(
        ['snippet'],
        id: [videoId],
      );

      if (video.items != null && video.items!.isNotEmpty) {
        final title = video.items!.first.snippet!.title!;
        setState(() {
          videoTitles.add(title);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.cyan,
          title: Text('YouTube Page'),
          centerTitle: true,
        ),
        body: ListView.builder(
          itemCount: videoUrls.length,
          itemBuilder: (BuildContext context, int index) {
            final String videoId = YoutubePlayer.convertUrlToId(videoUrls[index]) ?? '';

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    child: YoutubePlayer(
                      controller: YoutubePlayerController(
                        initialVideoId: videoId,
                        flags: YoutubePlayerFlags(
                          autoPlay: false,
                          mute: false,
                        ),
                      ),
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.redAccent,
                      ),
                      onReady: () {
                        // Do something when the player is ready
                      },
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    videoTitles.length > index ? videoTitles[index] : 'Video Title',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

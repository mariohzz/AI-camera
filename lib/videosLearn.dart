
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
class VideoList extends StatelessWidget {
  final List<String> videoIds;

  VideoList({required this.videoIds});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of videos per row
        childAspectRatio: 1.0, // Width to height ratio of each video card
      ),
      itemCount: videoIds.length,
      itemBuilder: (context, index) {
        final videoId = videoIds[index];
        return GestureDetector(
          onTap: () {
            // Handle video tap here
            print('Video $videoId tapped');
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: YoutubePlayerFlags(
                  autoPlay: false,
                  mute: false,
                ),
              ),
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: ProgressBarColors(
                playedColor: Colors.blueAccent,
                handleColor: Colors.blueAccent,
              ),
            ),
          ),
        );
      },
    );
  }
}




class _DatePicker extends StatefulWidget {
  @override
  __DatePickerState createState() => __DatePickerState();
}

class __DatePickerState extends State<_DatePicker> {
  final List<String> videoIds = [
    'yFZB88Jy9Mw',
    '_Kfu5iU7Qq4',
    'yAF6dh8a0Aw',
    '7HjMrv5Zq7g',
  ];
  final List<String> thumbnailUrls = [
    'images/babnski.jpg',
    'images/grasp.jpg',
    'images/rooting.jpg',
    'images/tonicneck.jpg'
  ];
  final List<String> titles = [
    'Babnski',
    'Grasp',
    'Rooting',
    'Tonicneck',
  ];
  final selectedItem = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videoIds.length,
        itemBuilder: (_, index) {
          return ValueListenableBuilder(
            valueListenable: selectedItem,
            builder: (_, value, __) => GestureDetector(
              onTap: () => onPressItem(index),
              child: VideoItem(
                videoId: videoIds[index],
                thumbnailUrl: thumbnailUrls[index],
                title: titles[index],
                selectedItem: index == selectedItem.value,
              ),
            ),
          );
        },
      ),
    );
  }

  void onPressItem(int index) {
    selectedItem.value = index;
    // Navigate to the corresponding page using the selected video ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPage(
          videoId: videoIds[index],
          thumbnailUrl: thumbnailUrls[index],
          title: titles[index],
        ),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final String videoId;
  final String thumbnailUrl;
  final String title;
  final bool selectedItem;

  const VideoItem({
    required this.videoId,
    required this.thumbnailUrl,
    required this.title,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: AssetImage(thumbnailUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                if (selectedItem)
                  Positioned(
                    top: 8,
                    left: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontWeight: selectedItem ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  final String videoId;
  final String thumbnailUrl;
  final String title;

  const VideoPage({
    required this.videoId,
    required this.thumbnailUrl,
    required this.title,
  });

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late YoutubePlayerController _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    _youtubePlayerController = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Learn'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(widget.thumbnailUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 16),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: Center(
              child: YoutubePlayer(
                controller: _youtubePlayerController,
                showVideoProgressIndicator: true,
                progressIndicatorColor: Colors.blueAccent,
                progressColors: ProgressBarColors(
                  playedColor: Colors.blueAccent,
                  handleColor: Colors.blueAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

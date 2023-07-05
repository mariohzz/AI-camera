
import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:python_project/animation/scale_transition.dart';
import 'package:python_project/auth/auth.dart';
import 'package:python_project/consts.dart';
import 'package:python_project/mockdata.dart';
import 'package:python_project/model/item_list.dart';
import 'package:python_project/paint_app/home_page.dart';
import 'package:python_project/schedule/schedule_page.dart';
import 'package:python_project/screens/LoginScreen.dart';
import 'package:python_project/sql/aiSction.dart.dart';
import 'package:python_project/utils.dart';
import 'package:python_project/widgets/day_item.dart';
import 'package:python_project/widgets/title_widgets.dart';
import 'package:video_player/video_player.dart';

import '../chatgpt/api/chat_api.dart';
import '../chatgpt/chat_page.dart';
import '../location.dart';
import '../navigation.dart';
import '../photoUpload.dart';
import '../upload.dart';
import '../userCreate.dart';

late final UserDatabase userDatabase;
late final Auth userAuth;
class MyListPage extends StatelessWidget {
  final username = 'jamescardona11';
  MyListPage(userDatabase,userAuth);
  // final User? user = Auth().currentuser;
  // Future<void> singout(BuildContext context) async {
  //   await Auth().signOut();
  //   Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
  // }
  //
  // Widget _title() {
  //   return const Text("FirebaseAuth");
  // }
  //
  // Widget _UserUid() {
  //   return Text(user?.email ?? 'User Email');
  // }
  //
  // Widget _singOutButton(BuildContext context) {
  //   return Container(
  //       margin: EdgeInsets.only(
  //         right: 320,
  //       ),
  //       child: TextButton(
  //           onPressed:() {
  //             singout(context);
  //           },
  //           child: const Text(
  //             'sing out',
  //             style: TextStyle(color: Color.fromARGB(255, 236, 104, 52)),
  //           )));
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.white,
    //       child: Padding(
    //         padding: EdgeInsets.all(8.0),
    //         child:Center(
    //            child: Expanded(child: _BottomContainer()),
    // )

        child: Column(
          children: [
             AppBar(
               backgroundColor: Colors.cyan,
               title: Text("Home"),
               centerTitle: true,

             ),
            //const Material3BottomNav(),
            //TitleWidget(title: 'My List'),
            //DatePicker(),
            // Center(
            //   child: CircularPhotoUploader(),
            // ),
            _DatePicker(),
            Expanded(child: _BottomContainer()),
          ],
        ),

      // ),
      // floatingActionButton: FloatingAddButtonPage(),
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key? key,
    required this.username,
  }) : super(key: key);

  final String username;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey, ${Auth().currentuser?.email}',
                  style: kStyleName.copyWith(fontSize: 26),
                ),
                const SizedBox(height: 5),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

class _DatePicker extends StatefulWidget {
  @override
  __DatePickerState createState() => __DatePickerState();
}

class __DatePickerState extends State<_DatePicker> {
  final List<String> videoUrls = [
    'https://raw.githubusercontent.com/username/repository/master/videos/video1.mp4',
    'https://raw.githubusercontent.com/username/repository/master/videos/video2.mp4',
    'https://raw.githubusercontent.com/username/repository/master/videos/video3.mp4',
    'https://raw.githubusercontent.com/username/repository/master/videos/video4.mp4',
    'https://raw.githubusercontent.com/username/repository/master/videos/video5.mp4',
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
        itemCount: videoUrls.length,
        itemBuilder: (_, index) {
          return ValueListenableBuilder(
            valueListenable: selectedItem,
            builder: (_, value, __) => GestureDetector(
              onTap: () => onPressItem(index),
              child: VideoItem(
                videoUrl: videoUrls[index],
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
    // Navigate to the corresponding page using the selected video URL
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPage(videoUrl: videoUrls[index]),
      ),
    );
  }
}

class VideoItem extends StatelessWidget {
  final String videoUrl;
  final bool selectedItem;

  const VideoItem({
    required this.videoUrl,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      child: Stack(
        children: [
          Image.network(
            'https://raw.githubusercontent.com/username/repository/master/images/placeholder.jpg',
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          if (selectedItem)
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                width: 80,
                height: 80,
                color: Colors.black.withOpacity(0.5),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class VideoPage extends StatefulWidget {
  final String videoUrl;

  const VideoPage({required this.videoUrl});

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
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
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Video Page'),
      ),
      body: Center(
        child: Chewie(
          controller: _chewieController,
        ),
      ),
    );
  }
}


class _BottomContainer extends StatelessWidget {
  final String tit = 'Upload File';
  final String sub = 'Browse and chose the video you want to upload.';
  @override
  Widget build(BuildContext context) {
    ////////////////////////////////////////////
    //screen navigation
    void navigateToScreen(BuildContext context, String screenIdentifier) {
      switch (screenIdentifier) {

        case 'screen1':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CameraHomeScreen(userDatabase,userAuth)),
          );
          break;
        case 'screen2':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const PaintPage()),
          );
          break;
        case 'screen3':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>  ChatApp(chatApi: ChatApi())),
          );
          break;
        case 'screen4':
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LocationSearchScreen()),
          );
          break;
      }

    }
    /////////////////////////////////////////////////////////////////////////

    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      child: GridView.count(
          padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
          physics: NeverScrollableScrollPhysics(),
          childAspectRatio: 0.9,
          crossAxisCount: 2,
          mainAxisSpacing: 3,
          crossAxisSpacing: 17,
          children: [
            SizedBox(),
            SizedBox(),

            // GestureDetector(
            //     onTap: () {
            //       navigateToScreen(
            //           context, 'screen2'); // Pass the identifier for screen 1
            //     },
            //
            //     child: Container(
            //       child: Column(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Padding(
            //               padding: const EdgeInsets.only(top: 5),
            //               child: Text('Art',
            //                   style: TextStyle(
            //                       fontSize: 18, fontWeight: FontWeight.bold)),
            //             ),
            //             Image.asset(
            //               width: 140,
            //               'images/vector-color-paint.png',
            //               fit: BoxFit.fill,
            //             ),
            //           ]),
            //       decoration: BoxDecoration(
            //         color: Colors
            //             .cyan, // Set the background color of the container
            //         borderRadius: BorderRadius.circular(
            //             8.0), // Set the border radius of the container
            //         boxShadow: [
            //           BoxShadow(
            //             color: Colors.grey.withOpacity(
            //                 0.5), // Set the color and opacity of the shadow
            //             spreadRadius: 2, // Set the spread radius of the shadow
            //             blurRadius: 5, // Set the blur radius of the shadow
            //             offset: Offset(0, 3), // Set the offset of the shadow
            //           ),
            //         ],
            //       ),
            //     )),
            GestureDetector(
                onTap: () {
                  navigateToScreen(
                      context, 'screen4'); // Pass the identifier for screen 1
                },
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 7),
                          child: Text('Location',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        Image.asset(
                          width: 100,
                          'images/maps.png',
                          fit: BoxFit.fill,
                        ),
                      ]),
                  decoration: BoxDecoration(
                    color: Colors
                        .cyan, // Set the background color of the container
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius of the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.5), // Set the color and opacity of the shadow
                        spreadRadius: 2, // Set the spread radius of the shadow
                        blurRadius: 5, // Set the blur radius of the shadow
                        offset: Offset(0, 3), // Set the offset of the shadow
                      ),
                    ],
                  ),
                )),
            GestureDetector(
                onTap: () {
                  navigateToScreen(
                      context, 'screen3'); // Pass the identifier for screen 1
                },
                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('DR.ChatGPT',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        Image.asset(
                          width: 140,
                          'images/chatg.png',
                          fit: BoxFit.fill,
                        ),
                      ]),
                  decoration: BoxDecoration(
                    color: Colors
                        .cyan, // Set the background color of the container
                    borderRadius: BorderRadius.circular(
                        8.0), // Set the border radius of the container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.5), // Set the color and opacity of the shadow
                        spreadRadius: 2, // Set the spread radius of the shadow
                        blurRadius: 5, // Set the blur radius of the shadow
                        offset: Offset(0, 3), // Set the offset of the shadow
                      ),
                    ],
                  ),
                )),
          ]),
    );
  }
}

class _MyListItem extends StatelessWidget {
  final ItemList itemList;

  const _MyListItem({
    Key? key,
    required this.itemList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: kBorderRadius,
          boxShadow: [
            BoxShadow(
                color: Colors.grey,
                offset: Offset(0, 2),
                blurRadius: 7,
                spreadRadius: -3),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /*
                CircularPercent(
                  size: 35,
                  percent: itemList.percent,
                  primaryColor: itemList.color,
                ),*/
                Icon(
                  itemList.icon,
                  color: itemList.color,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  itemList.name,
                  style: kStyleName,
                ),
              ],
            ),
            const SizedBox(height: 5),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 5),
                child: Image(
                  image: AssetImage(itemList.photo),
                  width: 120,
                  height: 120,
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            /*
            Wrap(
              runSpacing: 5,
              children: [
                _ChipTask(text: '${itemList.completeTask} completed', color: itemList.color),
                _ChipTask(text: '${itemList.leftTask} left', color: Colors.pinkAccent),
              ],
            )*/
          ],
        ),
      ),
    );
  }
}

class _ChipTask extends StatelessWidget {
  const _ChipTask({
    Key? key,
    required this.text,
    required this.color,
  }) : super(key: key);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.3),
        borderRadius: kBorderRadius,
      ),
      child: Text(
        text,
        style:
            TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
class ChatApp extends StatelessWidget {
  const ChatApp({required this.chatApi, super.key});

  final ChatApi chatApi;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatGPT Client',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          secondary: Colors.lime,
        ),
      ),
      home: ChatPage(chatApi: chatApi),
    );
  }
}

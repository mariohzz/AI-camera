
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
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../babysitter.dart';
import '../chatgpt/api/chat_api.dart';
import '../chatgpt/chat_page.dart';
import '../funpage.dart';
import '../location.dart';
import '../navigation.dart';
import '../photoUpload.dart';
import '../upload.dart';
import '../userCreate.dart';
import '../videoFun.dart';
import '../widgets/logo.dart';

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
        backgroundColor: Colors.brown,
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

              // VideoList(
              //   videoIds: [
              //     '7HjMrv5Zq7g',
              //     'yFZB88Jy9Mw'],),

            //const Material3BottomNav(),
            //TitleWidget(title: 'My List'),
            //DatePicker(),
            // Center(
            //   child: CircularPhotoUploader(),
            // ),
           // _DatePicker(),
            Stack(
              children: [
                Container(
                  width: 250,
                  height: 170,
                  child: Image.asset(
                    'images/baby1.png',
                    fit: BoxFit.cover,
                  ),
                ),

              ],
            ),
            SizedBox(height: 45,),
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
            MaterialPageRoute(builder: (context) =>  YoutubePage()),
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
          mainAxisSpacing: 8,
          crossAxisSpacing: 5,
          children: [

            // ElevatedButton(
            //
            //     onPressed:(){
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(builder: (context) => VideoList(
            //           videoIds: [
            //             '7HjMrv5Zq7g',
            //             'yFZB88Jy9Mw',
            //           ],
            //         ),),
            //       );
            // // }, child: Text("press"),
            // ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BabysitterPage()),
                );
              },
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text(
                        'Find',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(
                      'images/find.png',
                      width: 120,
                      fit: BoxFit.fill,
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: Colors.pink,
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
                  Navigator.push(
                    context,MaterialPageRoute(builder: (context)=>FunPage())
                  );
                  // navigateToScreen(
                  //     context, 'screen2'); // Pass the identifier for screen 1
                },

                child: Container(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('Fun',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(height:10,),
                        Image.asset(
                          width: 130,
                          'images/fun.jpg',
                          fit: BoxFit.fill,
                        ),
                      ]),
                  decoration: BoxDecoration(
                    color: Colors
                        .purpleAccent, // Set the background color of the container
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
                        .green, // Set the background color of the container
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
                        .orange, // Set the background color of the container
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

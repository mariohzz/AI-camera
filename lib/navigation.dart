//import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:python_project/screens/LoginScreen.dart';
import 'package:python_project/screens/my_list_page.dart';
import 'package:python_project/sql/aiSction.dart.dart';
import 'package:python_project/upload.dart';
import 'package:python_project/userCreate.dart';

import 'auth/auth.dart';

//Home Page

class Material3BottomNav extends StatefulWidget {
  final UserDatabase userDatabase;
  final int _selectedIndex;
  Material3BottomNav(this.userDatabase,this._selectedIndex ,{super.key});
  @override
  State<Material3BottomNav> createState() => _Material3BottomNavState(_selectedIndex);
}

class _Material3BottomNavState extends State<Material3BottomNav> {
  late PageController _pageController = PageController();
  int _selectedIndex;

  _Material3BottomNavState(this._selectedIndex);
  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _selectedIndex); // Initialize the PageController with the initial index
  }


  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final String tit = 'Upload File';
    final String sub = 'Browse and choose the video you want to upload.';
    bool showAppBar = false;

    return Scaffold(
      appBar: showAppBar ? AppBar(title: Text('Your App Bar Title')) : null,
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        children: [
          MyListPage(widget.userDatabase),
          CameraHomeScreen(widget.userDatabase),
          // UploadScreen(1, 'images/Picture.png', tit, sub),
          // Add other page classes here if desired
          ProfilePage(widget.userDatabase),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.cyan,
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: _navBarItems,
      ),
    );
  }
}

// //////////////////////////
// final User? user = Auth().currentuser;
// Future<void> singout(BuildContext context) async {
//   await Auth().signOut();
//   Navigator.push(
//     context,
//     MaterialPageRoute(builder: (context) =>  LoginScreen()),
//   );
//
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
//
//






class ProfilePage extends StatelessWidget {
  final User? user = Auth().currentuser;
  final UserDatabase userDatabase;
  ProfilePage(this.userDatabase);

  Future<void> signOut(BuildContext context) async {
    await Auth().signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen(this.userDatabase)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'User: ${user?.email ?? 'Unknown'}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                signOut(context);
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

}



const _navBarItems = [
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
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:python_project/photoUpload.dart';
import 'package:python_project/photourlprovider.dart';
import 'package:python_project/screens/LoginScreen.dart';
import 'package:python_project/sql/aiSction.dart.dart';
import 'package:python_project/userCreate.dart';
import 'package:python_project/widget_tree.dart';
import 'package:python_project/upload.dart';
import 'auth/auth.dart';
import 'navigation.dart';
import 'screens/my_list_page.dart';

Future<void> main() async{
 // await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());



  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    Auth userAuth = Auth();
    UserDatabase userDatabase = UserDatabase(userAuth);
    return ChangeNotifierProvider(
      create: (context) => PhotoUrlProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: HomeScreen(userAuth:userAuth,userDatabase: userDatabase,), // Replace with the HomeScreen widget
          //bottomNavigationBar: const BottomBarWidget(),
        ),
      ),
    );
  }
}
class HomeScreen extends StatelessWidget {
  final UserDatabase userDatabase;
  final Auth userAuth;

  const HomeScreen({required this.userDatabase, required this.userAuth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('My App'),
      // ),
      body: Column(
        children: [
          //CircularPhotoUploader(userDatabase),
          Expanded(
            //
            child: WidgetTree(userDatabase, userAuth),
          ),
        ],
      ),
    );
  }
}
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
import 'package:introduction_screen/main.dart';
import 'auth/auth.dart';
import 'navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'screens/my_list_page.dart';

Future<void> main() async{
 // await dotenv.load(fileName: ".env");

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());



  //runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SharedPreferences _prefs;
  bool _showIntro = false;

  @override
  void initState() {
    super.initState();
    _loadPreferences();
  }

  Future<void> _loadPreferences() async {
    _prefs = await SharedPreferences.getInstance();
    bool showIntro = _prefs.getBool('showIntro') ?? true;
    setState(() {
      _showIntro = showIntro;
    });
  }

  Future<void> _updatePreferences() async {
    await _prefs.setBool('showIntro', true);
  }

  @override
  Widget build(BuildContext context) {
    Auth userAuth = Auth();
    UserDatabase userDatabase = UserDatabase(userAuth);
    CircularPhotoUploader photo;
    return ChangeNotifierProvider(
      create: (context) => PhotoUrlProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: _showIntro
              ? IntroScreen(
            onDone: () {
              _updatePreferences().then((_) {
                setState(() {
                  _showIntro = false;
                });
              });
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(userDatabase: userDatabase,userAuth: userAuth),
                ),
              );
            },
          )
              : HomeScreen(userDatabase: userDatabase,userAuth: userAuth),
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
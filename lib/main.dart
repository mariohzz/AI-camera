import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    Auth userAuth = Auth();
    UserDatabase userDatabase = UserDatabase(userAuth);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: WidgetTree(userDatabase),
        ),
        //bottomNavigationBar: const BottomBarWidget(),
      ),
    );
  }
}

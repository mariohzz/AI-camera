import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:python_project/screens/LoginScreen.dart';
import 'package:python_project/sql/aiSction.dart.dart';
import 'package:python_project/widget_tree.dart';
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
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child:  MyListPage(),
        ),
        //bottomNavigationBar: const BottomBarWidget(),
      ),
    );
  }
}

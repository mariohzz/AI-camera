import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:python_project/auth/auth.dart';
import 'package:python_project/screens/LoginScreen.dart';
import 'package:python_project/screens/my_list_page.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, Snapshot) {
        if (Snapshot.hasData) {
          return MyListPage();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}

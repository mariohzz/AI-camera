import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:python_project/auth/auth.dart';
import 'package:python_project/screens/LoginScreen.dart';
import 'package:python_project/screens/my_list_page.dart';
import 'package:python_project/userCreate.dart';

import 'navigation.dart';

class WidgetTree extends StatefulWidget {
  final UserDatabase userDatabase;
  const WidgetTree(this.userDatabase);

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
          return Material3BottomNav(widget.userDatabase,0);
        } else {
          return LoginScreen(widget.userDatabase);
        }
      },
    );
  }
}

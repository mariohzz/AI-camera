import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 255, 236, 153),
      child: Center(
        child: Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: new AssetImage("images/Picture1.png"),
              fit: BoxFit.cover,
            ))),
      ),
    );
  }
}

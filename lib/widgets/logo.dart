import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final String text;
  @override
  _AnimatedTextState createState() => _AnimatedTextState(this.text);
  AnimatedText(this.text);
}
class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  final String Text;
  _AnimatedTextState(this.Text);
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController);

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(
      fontSize: 20.0,
      fontFamily: 'Horizon',
    );
    return SizedBox(
      width: 250.0,
      child: AnimatedTextKit(
        animatedTexts: [
          ColorizeAnimatedText(
            Text,
            textStyle: colorizeTextStyle,
            colors: colorizeColors,
          ),
        ],
        isRepeatingAnimation: true,
        onTap: () {
          print("Tap Event");
        },
      ),
    );
    // return AnimatedOpacity(
    //   opacity: _opacityAnimation.value,
    //   duration: Duration(seconds: 1),
    //   child: Text(
    //     'Baby care',
    //     style: TextStyle(
    //       color: Colors.black,
    //       fontSize: 16,
    //     ),
    //   ),
    // );
  }
}

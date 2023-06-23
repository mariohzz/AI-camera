import 'package:flutter/material.dart';
import 'package:python_project/consts.dart';

class TitleWidget extends StatelessWidget {
  final String title;

  const TitleWidget({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: kStyleName.copyWith(fontSize: 18),
      ),
    );
  }
}

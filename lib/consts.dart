import 'package:flutter/material.dart';
const length = 3;

const topSize = 95.0;
const duration = Duration(milliseconds: 600);
const circleSize = 65.0;
const barSize = 63.0;
const borderCircle = 8.0;
const iconSize = 35.0;


const kStyleName = TextStyle(
  fontSize: 18,
  fontFamily: 'Raleway',
  fontWeight: FontWeight.w700,
  color: Colors.black87,
);

const kGreyStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'Raleway',
  fontWeight: FontWeight.bold,
);

const kWhiteStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

const kBorderRadius = BorderRadius.all(Radius.circular(15));
const scaffoldColor = Color(0xff00171D);
const waveColor = Color(0xff11BFEB);
const lightWaveColor = Color(0xff007797);
const heartColor = Color(0xffFF4B4B);
const greenHighlight = Color(0xff26DF29);

const instructions = "Place your index finger tightly on camera.";
const processText = "Analyzing...";
const warning = "Warning: finger not placed correctly";
/*
TextStyle appText(
    {required Color color,
    double? size,
    required FontWeight weight,
    bool isShadow = false}) {
  return GoogleFonts.poppins(
    color: color,
    fontSize: size,
    fontWeight: weight,
    shadows: isShadow
        ? [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset: const Offset(0.6, 4),
                spreadRadius: 1,
                blurRadius: 8)
          ]
        : [],
  );
  
}*/

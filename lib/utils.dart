import 'dart:core';

int daysInMonth() {
  final now = DateTime.now();
  final firstDayThisMonth = DateTime(now.year, now.month, now.day);
  final firstDayNextMonth = DateTime(firstDayThisMonth.year, firstDayThisMonth.month + 1, firstDayThisMonth.day);
  return firstDayNextMonth.difference(firstDayThisMonth).inDays;
}

String dayName(int day) {
  //Fake
  int finalDay = day;

  if (day > 7) {
    final delta = (day / 7).floor();
    finalDay = finalDay - delta * 7;
    if (finalDay == 0) finalDay = 7;
  }

  switch (finalDay) {
    case 1:
      return 'Mon';
    case 2:
      return 'Tue';
    case 3:
      return 'Wed';
    case 4:
      return 'Thu';
    case 5:
      return 'Fry';
    case 6:
      return 'Sat';
    case 7:
      return 'Sun';
  }

  return 'Mon';
}
/*
  velocity_x: ^3.6.0    
  flutter_mjpeg: ^2.0.3
  video_player: ^2.6.1
  sqflite: ^2.2.8+4
  firebase_core: ^2.14.0
  firebase_auth: ^4.6.3
  chat_gpt_sdk: ^1.0.2
  path_provider: ^2.0.15
  http: ^0.13.4
  web_socket_channel: ^2.4.0
  eventsource: ^0.4.0
  file_picker: ^5.3.2
  firebase_storage: ^11.2.3
  dart_openai: ^3.0.0
  fluttertoast: ^8.2.2
  flutter_colorpicker: ^1.0.3
  breathing_collection: ^1.0.0+3
  font_awesome_flutter: ^10.1.0
  flutter_camera: ^0.1.1
  image: ^3.2.0
  lottie: ^1.3.0
  flutter_dotenv: ^5.0.2
  */
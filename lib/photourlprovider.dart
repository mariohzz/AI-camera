import 'package:flutter/foundation.dart';

class PhotoUrlProvider with ChangeNotifier {
  String? _photoUrl;

  String? get photoUrl => _photoUrl;

  set photoUrl(String? value) {
    _photoUrl = value;
    notifyListeners();
  }
}
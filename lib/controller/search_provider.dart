import 'package:flutter/foundation.dart';

class SearchProvider extends ChangeNotifier {
  String? username;

  searchMethod(value) {
    username = value;
    notifyListeners();
  }
}

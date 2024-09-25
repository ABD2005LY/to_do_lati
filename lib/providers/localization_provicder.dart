import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider with ChangeNotifier {
  String? language;


  getlanguage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    language = prefs.getString("lang") ?? "en";
    notifyListeners();
  }

  storelanguage(String langu) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", langu);
    getlanguage();
  }
}

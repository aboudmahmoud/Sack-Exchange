import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


import '../../moudel/QusteionMoudel.dart';


class LoactDataRepo{
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)!);
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
 static var _qusteionMoudel=QusteionMoudel().obs;

  static get qusteionMoudel => _qusteionMoudel.value;

  static set qusteionMoudel(value) {
    _qusteionMoudel.value = value;

  }


}


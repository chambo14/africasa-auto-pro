import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/response_model.dart';


class SharedPreferencesServices {
  static SharedPreferences? _preferencesAuth;

  static void saveToken(String token) async {
    await getPreference();
    _preferencesAuth!
        .setString("token", token);
  }


  static void saveUser(Data user) async{
    await getPreference();
    _preferencesAuth!.setString("user", json.encode(user));

  }

  static Future<Data?> getUser() async {
    await getPreference();
    var data = _preferencesAuth!.getString("user");
    if (data == null) return null;
    return Data.fromJson(jsonDecode(data));

  }




  static Future getPreference() async {
    _preferencesAuth ??= await SharedPreferences.getInstance();
  }

  static Future clearAll() async {
    await getPreference();
    await _preferencesAuth!.clear();
  }
}

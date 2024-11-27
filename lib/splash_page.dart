import 'dart:async';

import 'package:africasa_mecano/home_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'domain/models/response_model.dart';
import 'domain/shared_preferences.dart';
import 'login_page.dart';
import 'menu_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Data? data;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      getAccessApp();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/africasaPro.png", width: 260,)


          ],
        ),
      ),
    );
  }

  getAccessApp() async  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString("tokens");
    data = await SharedPreferencesServices.getUser();

    if(data!=null && token!.isNotEmpty){
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }

  }
}

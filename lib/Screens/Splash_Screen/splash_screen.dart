import 'dart:async';
import 'package:elite_crm/Screens/bottomNavigationPages.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Utils/gradient_color.dart';
import '../LoginScreen/login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  static const String KEYLOGIN = "Login";




  @override
  void initState() {
    super.initState();
    wheretogo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        decoration: gradient_login,
        child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Image.asset('assets/images/logo.png'),
            )),
      ),
    );
  }

  void wheretogo() async {
    var sharedpref = await SharedPreferences.getInstance();
    var isLoggedIn = sharedpref.getBool(KEYLOGIN);


    Timer( Duration(milliseconds:1300), () {
      if (isLoggedIn != null) {
        if (isLoggedIn) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => const Homepage()));
        } else {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => const LoginPage()));
        }
      }else{
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>  const LoginPage()));
      }
    });
  }

}
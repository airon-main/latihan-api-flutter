import 'package:flutter/material.dart';
import 'package:latihan_api_flutter/Login.dart';
import 'package:latihan_api_flutter/ProductListPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  SharedPreferences? prefs;

  void initialObject(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getString("username") != "") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ProductListPage()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      initialObject(context);
    });
    return const Placeholder();
  }
}

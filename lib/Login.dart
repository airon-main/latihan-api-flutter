import 'package:flutter/material.dart';
import 'package:latihan_api_flutter/ProductListPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginStatePage();
}

class _LoginStatePage extends State<LoginPage> {
  TextEditingController ctrUsername = TextEditingController();
  TextEditingController ctrPassword = TextEditingController();
  SharedPreferences? prefs;

  void intialObject() async {
    prefs = await SharedPreferences.getInstance();
  }

  Widget myTextField(
      String label, bool isObscure, TextEditingController myController) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        controller: myController,
        obscureText: isObscure,
        decoration: InputDecoration(
          label: Text(label),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    intialObject();
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: Center(
        child: Container(
          child: Column(
            children: [
              myTextField("Username", false, ctrUsername),
              myTextField("Password", true, ctrPassword),
              ElevatedButton(
                onPressed: () async {
                  //save button akan menyimpan token
                  await prefs!
                      .setString('username', ctrUsername.text.toString());
                  await prefs!
                      .setString('password', ctrPassword.text.toString());
                  //pindah ke halaman lain
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductListPage()));
                },
                child: const Text("Sign Up"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

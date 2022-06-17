import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_dot_technical_app/view/login_page.dart';

class SplashPage extends StatefulWidget {
  static const routeName = 'splashPage';
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 1), (){
      Navigator.popAndPushNamed(context, LoginPage.routeName);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.transparent,
        alignment: Alignment.center,
        child: const Text(
          'Selamat Datang !',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}

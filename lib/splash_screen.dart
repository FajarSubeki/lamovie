import 'dart:async';
import 'package:flutter/material.dart';
import 'package:core/core.dart';
import 'package:core/presentation/pages/home_page.dart';

import 'main.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  _startSplashScreen() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, _navigationPage);
  }

  void _navigationPage() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage())
    );
  }

  @override
  void initState() {
    super.initState();
    _startSplashScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kOxfordBlue,
      body: SafeArea(
          child: Center(
            child: Text(
              'Lamovie',
              style: kTextTheme.headlineSmall?.copyWith(
                fontSize: 50,
                color: Colors.white
              ),
            ),
          )
      ),
    );
  }
}
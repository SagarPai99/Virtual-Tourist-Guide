import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:vrtguide/pages/FirstPage.dart';
import 'package:vrtguide/pages/HomePage.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flare_flutter/flare_actor.dart';

void main() {
  ErrorWidget.builder = (FlutterErrorDetails details) => Center(
        child: Text(
          "An unexpected error occured.\nContact us at <email> for further details.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xff9FA0B5),
          ),
        ),
      );
  runApp(Home());
}

class Home extends StatefulWidget {
  createState() => HomeState();
}

class HomeState extends State<Home> {
  int checkState = 0;
  List<Widget> pages = [
    FlareActor(
      "lib/assets/loading_pizza.flr",
      alignment: Alignment.center,
      fit: BoxFit.contain,
      animation: "Pizza Bounce",
    ),
    FirstPage(),
    HomePage(),
  ];

  HomeState() {
    beginCheck();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.purple,
      ),
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        top: false,
        bottom: false,
        left: false,
        right: false,
        child: Center(
          child: Container(
            color: Colors.white,
            child: pages[checkState],
          ),
        ),
      ),
    );
  }

  void beginCheck() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool firstTime = prefs.getBool("firstTime") ?? true;
      // await prefs.setBool("firstTime", false);
      setState(() {
        checkState = firstTime ? 1 : 2;
      });
    } catch (e) {
      print(e);
      setState(() {
        checkState = 1;
      });
    }
  }
}

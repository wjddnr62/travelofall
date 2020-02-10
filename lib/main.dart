import 'dart:async';

import 'package:flutter/material.dart';
import 'package:travelofall/public/color.dart';
import 'package:travelofall/routes.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: Splash(),
  routes: routes,
));

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: mainColor,
        child: Padding(
          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4, right: MediaQuery.of(context).size.width / 4, bottom: MediaQuery.of(context).size.height / 3),
            child: Image.asset("assets/logo.png", width: MediaQuery.of(context).size.width, height: 60,)
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    startTime();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed('/Home');
  }

}
import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Util/delegate.dart';
import 'package:travelofall/public/color.dart';
import 'package:travelofall/routes.dart';

import 'Server/Model/user.dart';

void main() {
  runApp(RestartWidget(
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash(),
      routes: routes,
      supportedLocales: [
        const Locale('ko', 'KR'),
        const Locale('en', 'US'),
        const Locale('ja', 'JP'),
        const Locale('zh-chs', 'CN')
      ],
      localizationsDelegates: [
        const TranslationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
        if (locale == null) {
          debugPrint("*language locale is null!!!");
          return supportedLocales.first;
        }

        for (Locale supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode ||
              supportedLocale.countryCode == locale.countryCode) {
            debugPrint("*language ok $supportedLocale");
            return supportedLocale;
          }
        }

        debugPrint("*language to fallback ${supportedLocales.first}");
        return supportedLocales.first;
      },
    ),
  ));
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class RestartWidget2 extends StatefulWidget {
  RestartWidget2({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState2>().restartApp();
  }

  @override
  _RestartWidgetState2 createState() => _RestartWidgetState2();
}

class _RestartWidgetState2 extends State<RestartWidget2> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

class Splash extends StatefulWidget {
  @override
  _Splash createState() => _Splash();
}

class _Splash extends State<Splash> {

  SharedPreferences prefs;

  sharedInit() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.getString("email") != "" && prefs.getString("email") != null) {
      mainBloc.setEmail(prefs.getString("email"));
      mainBloc.setPass(prefs.getString("pass"));

      mainBloc.loginUser().then((value) async {
        if (json.decode(value)['result'] == 1) {
          if (json.decode(value)['data'] != "notUser") {
            print("check");

            dynamic data = await json.decode(value)['data'];
            UserData userData = UserData(
                idx: data['idx'],
                type: data['type'],
                email: data['email'],
                name: data['name'],
                birthday: data['birthday'],
                phone: data['phone'],
                company: data['company'],
                company_number: data['company_number'],
                rep_phone: data['rep_phone'],
                site: data['site'],
                address: data['address']
            );

            print("check2 : ${userData.email}");
            mainBloc.userData = userData;
            await Navigator.of(context).pushReplacementNamed("/Home");
          }
        }
      });
    } else {
      startTime();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: mainColor,
        child: Center(
//          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 4, right: MediaQuery.of(context).size.width / 4, bottom: MediaQuery.of(context).size.height / 3),
            child: Image.asset("assets/logo_white.png", fit: BoxFit.fill,)
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    sharedInit();
  }

  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async {
    await Navigator.of(context).pushReplacementNamed('/Home');
  }

}
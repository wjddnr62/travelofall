import 'package:travelofall/Screens/Drawer/contactus.dart';
import 'package:travelofall/Screens/Map/dateselect.dart';

import 'Screens/Drawer/notice.dart';
import 'Screens/Home/home.dart';
import 'Screens/Login/login.dart';
import 'Screens/Register/register.dart';
import 'main.dart';

final routes = {
  '/Splash': (context) => Splash(),
  '/Home': (context) => Home(),
  '/Register': (context) => Register(),
  '/Login': (context) => Login(),
  '/Notice': (context) => Notice(),
  '/ContactUs': (context) => ContactUs(),
  '/DateSelect': (context) => DateSelect()
};

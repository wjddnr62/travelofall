import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelofall/Screens/Login/login.dart';
import 'package:travelofall/Screens/Register/register.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Server/Model/user.dart';
import 'package:travelofall/Util/translations.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/main.dart';
import 'package:travelofall/public/color.dart';

registerDialog(context) {
  return showDialog(
//        barrierDismissible: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 133.3,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(3.3)),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 133.3,
                      color: mainColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/register/icon_person_1.png",
                            width: 78,
                            height: 78,
                          ),
                          whiteSpaceH(4),
                          Text(
                            "운영자\n회원가입",
                            style: TextStyle(
                                color: white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                decoration: TextDecoration.none),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Register()));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 133.3,
                      color: white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            "assets/register/icon_person_2.png",
                            width: 78,
                            height: 78,
                          ),
                          whiteSpaceH(4),
                          Text(
                            "사용자\n회원가입",
                            style: TextStyle(
                                color: mainColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

baseDrawer(context) {
  bool loginCheck = false;
  UserData userData;
  if (mainBloc.userData != null) {
    userData = mainBloc.userData;
    if (userData.email != null) {
      loginCheck = true;
    }
  }

  print("loginCheck : ${loginCheck}");

  SharedPreferences prefs;

  logout() async {
    prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    mainBloc.userData = null;
    Navigator.of(context).pushNamedAndRemoveUntil("/Home", (route) => false);
  }

  String select = "한국어";

  if (mainBloc.locale == "ko") {
    select = "한국어";
  } else if (mainBloc.locale == "en") {
    select = "English";
  } else if (mainBloc.locale == "ja") {
    select = "日本語";
  } else if (mainBloc.locale == "zh-chs") {
    select = "汉语";
  }

  return Stack(
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    top: 10 + MediaQuery.of(context).padding.top, left: 10),
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(
                    Icons.close,
                    color: black,
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10 + MediaQuery.of(context).padding.top, right: 10),
                child: Container(
                  width: 80,
                  height: 30,
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      elevation: 0,
                      style: TextStyle(color: black),
                      items: ['한국어', 'English', '日本語', '汉语'].map((value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Center(
                            child: Text(
                              value,
                              style: TextStyle(
                                  color: Color(0xFF333333), fontSize: 12),
                            ),
                          ),
                        );
                      }).toList(),
                      value: select,
                      onChanged: (value) {
                        select = value;
                        if (value == "한국어") {
                          mainBloc.locale = "ko";
                        } else if (value == "English") {
                          mainBloc.locale = "en";
                        } else if (value == "日本語") {
                          mainBloc.locale = "ja";
                        } else if (value == "汉语") {
                          mainBloc.locale = "zh-chs";
                        }

                        RestartWidget.restartApp(context);

//                        Navigator.of(context).pushNamedAndRemoveUntil(
//                            "/Splash", (route) => false);
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
          whiteSpaceH(20),
//          Center(
//            child: ClipOval(
//              child: Image.asset(
//                "assets/drawer/icon_default_profile.png",
//                width: 96,
//                height: 96,
//              ),
//            ),
//          ),
//          whiteSpaceH(15),
//          Center(
//            child: GestureDetector(
//              onTap: () {
//                Navigator.of(context)
//                    .push(MaterialPageRoute(builder: (context) => Login()));
//              },
//              child: Text(
//                "로그인",
//                style: TextStyle(
//                    fontSize: 16, fontWeight: FontWeight.bold, color: black),
//                textAlign: TextAlign.center,
//              ),
//            ),
//          ),
          whiteSpaceH(15),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Color(0xFFDDDDDD),
          ),
          RaisedButton(
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "서비스 준비 중입니다.",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: black,
                  textColor: white,
                  fontSize: 14);
            },
            elevation: 0.0,
            color: white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: <Widget>[
                  whiteSpaceW(20),
                  Image.asset(
                    "assets/drawer/icon_basket.png",
                    width: 36,
                    height: 36,
                  ),
                  whiteSpaceW(15),
                  Text(
                    "${Translations.of(context).trans('shoppingBasket')} (0)",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Color(0xFFDDDDDD),
          ),
          RaisedButton(
            onPressed: () {},
            elevation: 0.0,
            color: white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: <Widget>[
                  whiteSpaceW(20),
                  Image.asset(
                    "assets/drawer/icon_notice.png",
                    width: 36,
                    height: 36,
                  ),
                  whiteSpaceW(15),
                  Text(
                    "${Translations.of(context).trans('notice')}",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {},
            elevation: 0.0,
            color: white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: <Widget>[
                  whiteSpaceW(20),
                  Image.asset(
                    "assets/drawer/icon_discount.png",
                    width: 36,
                    height: 36,
                  ),
                  whiteSpaceW(15),
                  Text(
                    "${Translations.of(context).trans('discount/event')}",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {},
            elevation: 0.0,
            color: white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: <Widget>[
                  whiteSpaceW(20),
                  Image.asset(
                    "assets/drawer/icon_question.png",
                    width: 36,
                    height: 36,
                  ),
                  whiteSpaceW(15),
                  Text(
                    "${Translations.of(context).trans('contactUs')}",
                    style: TextStyle(
                        color: black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {},
            elevation: 0.0,
            color: white,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                children: <Widget>[
                  whiteSpaceW(20),
                  Image.asset(
                    "assets/drawer/icon_recomand.png",
                    width: 36,
                    height: 36,
                  ),
                  whiteSpaceW(15),
                  Flexible(
                    child: Text(
                      "${Translations.of(context).trans('reco')}",
                      style: TextStyle(
                          color: black,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
          (mainBloc.userData != null && userData.type == 0)
              ? RaisedButton(
                  onPressed: () {},
                  elevation: 0.0,
                  color: white,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    child: Row(
                      children: <Widget>[
                        whiteSpaceW(20),
                        Image.asset(
                          "assets/drawer/icon_operator.png",
                          width: 36,
                          height: 36,
                        ),
                        whiteSpaceW(15),
                        Text(
                          "${Translations.of(context).trans('operatorBulletin')}",
                          style: TextStyle(
                              color: black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                )
              : Container(),
        ],
      ),
      !loginCheck
          ? Align(
              alignment: Alignment.bottomCenter,
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Login()));
                },
                color: Color(0xFFEEEEEE),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Center(
                    child: Text(
                      "${Translations.of(context).trans('login')}",
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            )
          : Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      color: Color(0xFFEEEEEE),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Center(
                          child: Text(
                            "${Translations.of(context).trans('personalInformationModification')}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        logout();
                      },
                      color: Color(0xFFEEEEEE),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Center(
                          child: Text(
                            "${Translations.of(context).trans('logout')}",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
    ],
  );
}

//baseDrawer(context) {
//  return Column(
//    children: <Widget>[
//      whiteSpaceH(MediaQuery.of(context).padding.top),
//      Container(
//        width: MediaQuery.of(context).size.width,
//        height: 80,
//        color: mainColor,
//        padding: EdgeInsets.only(top: 36, left: 16, right: 16),
//        child: Row(
//          children: <Widget>[
//            Expanded(
//              child: GestureDetector(
//                onTap: () {
//                  Navigator.of(context).push(
//                      MaterialPageRoute(builder: (context) => Login()));
//                },
//                child: Container(
//                  width: MediaQuery.of(context).size.width,
//                  height: 32,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(3.3),
//                      color: white),
//                  child: Center(
//                    child: Text(
//                      "로그인",
//                      style: TextStyle(
//                        color: mainColor,
//                        fontSize: 14,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//            whiteSpaceW(5),
//            Expanded(
//              child: GestureDetector(
//                onTap: () {
//                  registerDialog(context);
//                },
//                child: Container(
//                  width: MediaQuery.of(context).size.width,
//                  height: 32,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(3.3),
//                      color: mainColor,
//                      border: Border.all(color: white, width: 1)),
//                  child: Center(
//                    child: Text(
//                      "회원가입",
//                      style: TextStyle(
//                        color: white,
//                        fontSize: 14,
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//      whiteSpaceH(8),
//      RaisedButton(
//        onPressed: () {
//          Navigator.of(context).pushNamed('/Notice');
//        },
//        elevation: 0.0,
//        padding: EdgeInsets.all(0),
//        color: white,
//        child: Container(
//          width: MediaQuery.of(context).size.width,
//          height: 48,
//          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              whiteSpaceW(16),
//              Image.asset(
//                "assets/drawer/icon_notice.png",
//                width: 24,
//                height: 24,
//              ),
//              whiteSpaceW(32),
//              Text(
//                "공지사항",
//                style: TextStyle(fontSize: 14, color: black),
//              )
//            ],
//          ),
//        ),
//      ),
//      Container(
//        width: MediaQuery.of(context).size.width,
//        height: 48,
//        color: white,
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            whiteSpaceW(16),
//            Image.asset(
//              "assets/drawer/icon_event.png",
//              width: 24,
//              height: 24,
//            ),
//            whiteSpaceW(32),
//            Text(
//              "할인/이벤트",
//              style: TextStyle(fontSize: 14, color: black),
//            )
//          ],
//        ),
//      ),
//      RaisedButton(
//        onPressed: () {
//          Navigator.of(context).pushNamed('/ContactUs');
//        },
//        padding: EdgeInsets.all(0),
//        elevation: 0.0,
//        color: white,
//        child: Container(
//          width: MediaQuery.of(context).size.width,
//          height: 48,
//          child: Row(
//            crossAxisAlignment: CrossAxisAlignment.center,
//            children: <Widget>[
//              whiteSpaceW(16),
//              Image.asset(
//                "assets/drawer/icon_contact.png",
//                width: 24,
//                height: 24,
//              ),
//              whiteSpaceW(32),
//              Text(
//                "문의하기",
//                style: TextStyle(fontSize: 14, color: black),
//              )
//            ],
//          ),
//        ),
//      ),
//      Container(
//        width: MediaQuery.of(context).size.width,
//        height: 48,
//        color: white,
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            whiteSpaceW(16),
//            Image.asset(
//              "assets/drawer/icon_recommend.png",
//              width: 24,
//              height: 24,
//            ),
//            whiteSpaceW(32),
//            Text(
//              "추천 축제/행사",
//              style: TextStyle(fontSize: 14, color: black),
//            )
//          ],
//        ),
//      ),
//      Container(
//        width: MediaQuery.of(context).size.width,
//        height: 48,
//        color: white,
//        child: Row(
//          crossAxisAlignment: CrossAxisAlignment.center,
//          children: <Widget>[
//            whiteSpaceW(16),
//            Image.asset(
//              "assets/drawer/icon_write.png",
//              width: 24,
//              height: 24,
//            ),
//            whiteSpaceW(32),
//            Text(
//              "운영자 게시판",
//              style: TextStyle(fontSize: 14, color: black),
//            )
//          ],
//        ),
//      )
//    ],
//  );
//}

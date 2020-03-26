import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelofall/Screens/Register/register.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Server/Model/user.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/main.dart';
import 'package:travelofall/public/color.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  int type = 1;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  FocusNode passNode = FocusNode();

  SharedPreferences prefs;

  sharedInit() async {
    prefs = await SharedPreferences.getInstance();
  }

  loginSave() async {
    await prefs.setString("email", emailController.text);
    await prefs.setString("pass", passController.text);
  }

  @override
  void initState() {
    super.initState();

    sharedInit();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top,
                child: Padding(
                  padding: EdgeInsets.only(left: 32, right: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      whiteSpaceH(30),
                      Image.asset(
                        "assets/logo_color.png",
                        fit: BoxFit.fill,
                      ),
                      whiteSpaceH(10.7),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          onFieldSubmitted: (value) {
                            FocusScope.of(context).requestFocus(passNode);
                          },
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFDDDDDD))),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 167, 167, 167)),
                              hintText: "이메일",
                              contentPadding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10)),
                        ),
                      ),
                      whiteSpaceH(10),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        child: TextFormField(
                          controller: passController,
                          textInputAction: TextInputAction.next,
                          obscureText: true,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1, color: Color(0xFFDDDDDD))),
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 167, 167, 167)),
                              hintText: "비밀번호",
                              contentPadding: EdgeInsets.only(
                                  top: 10, bottom: 10, left: 10)),
                        ),
                      ),
                      whiteSpaceH(20),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        decoration: BoxDecoration(
                            color: mainColor,
                            border: Border.all(width: 1.3, color: white)),
                        child: RaisedButton(
                          onPressed: () {
                            if (emailController.text == "" || emailController.text == null) {
                              Fluttertoast.showToast(
                                  msg: "이메일을 입력해주세요.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: black,
                                  textColor: white,
                                  fontSize: 14);
                            } else if (passController.text == "" || passController.text == null) {
                              Fluttertoast.showToast(
                                  msg: "비밀번호를 입력해주세요.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: black,
                                  textColor: white,
                                  fontSize: 14);
                            } else {
                              mainBloc.setEmail(emailController.text);
                              mainBloc.setPass(passController.text);

                              mainBloc.loginUser().then((value) {
                                if (json.decode(value)['result'] == 1) {
                                  if (json.decode(value)['data'] != "notUser") {
                                    dynamic data = json.decode(value)['data'];
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

                                    mainBloc.userData = userData;
                                    loginSave();
                                    Navigator.of(context).pushNamedAndRemoveUntil("/Home", (Route<dynamic> route) => false);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "로그인에 실패하였습니다.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: black,
                                        textColor: white,
                                        fontSize: 14);
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "로그인에 실패하였습니다.",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      backgroundColor: black,
                                      textColor: white,
                                      fontSize: 14);
                                }
                              });
                            }
                          },
                          elevation: 0.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6.7)),
                          color: mainColor,
                          child: Center(
                            child: Text(
                              "로그인",
                              style: TextStyle(
                                  color: white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                      whiteSpaceH(9.3),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 20,
                                color: white,
                                child: Center(
                                  child: Text(
                                    "계정 찾기",
                                    style:
                                        TextStyle(fontSize: 12, color: black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          whiteSpaceW(10),
                          Container(
                            width: 1,
                            height: 8,
                            color: Color(0xFFDDDDDD),
                          ),
                          whiteSpaceW(10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 20,
                                color: white,
                                child: Center(
                                  child: Text(
                                    "비밀번호 찾기",
                                    style:
                                        TextStyle(fontSize: 12, color: black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          whiteSpaceW(10),
                          Container(
                            width: 1,
                            height: 8,
                            color: Color(0xFFDDDDDD),
                          ),
                          whiteSpaceW(10),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => Register(
                                    )));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: 20,
                                color: white,
                                child: Center(
                                  child: Text(
                                    "회원가입",
                                    style:
                                        TextStyle(fontSize: 12, color: black),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                bottom: 50,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "Copyright ⓒ모두의여행. All Rights Reserved.",
                    style: TextStyle(color: Color(0xFF888888), fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Positioned(
                  top: 10,
                  left: 10,
                  child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.close),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

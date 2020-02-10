import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: mainColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: EdgeInsets.only(left: 32, right: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  whiteSpaceH(MediaQuery.of(context).size.height / 5),
                  Image.asset("assets/logo.png", width: 160, height: 63, fit: BoxFit.fill,),
                  whiteSpaceH(70),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 1;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 31.3,
                            color: mainColor,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  child: Center(
                                    child: Text("회원", style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w600, color: white
                                    ),),
                                  ),
                                ),
                                type == 1 ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 1.3, color: white,
                                ) : Container()
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 0;
                            });
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 31.3,
                            color: mainColor,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  child: Center(
                                    child: Text("운영자", style: TextStyle(
                                        fontSize: 14, fontWeight: FontWeight.w600, color: white
                                    ),),
                                  ),
                                ),
                                type == 0 ? Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 1.3, color: white,
                                ) : Container()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  whiteSpaceH(10.7),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 46.7,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(6.7)
                    ),
                    child: TextFormField(
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (value) {
                        FocusScope.of(context).requestFocus(passNode);
                      },
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          hintText: "이메일",
                          contentPadding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10)),
                    ),
                  ),
                  whiteSpaceH(9.3),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 46.7,
                    decoration: BoxDecoration(
                        color: white,
                        borderRadius: BorderRadius.circular(6.7)
                    ),
                    child: TextFormField(
                      controller: passController,
                      textInputAction: TextInputAction.next,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                              fontSize: 14,
                              color: Color.fromARGB(255, 167, 167, 167)),
                          hintText: "비밀번호",
                          contentPadding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 10)),
                    ),
                  ),
                  whiteSpaceH(10.7),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 46.7,
                    decoration: BoxDecoration(
                      color: mainColor,
                      borderRadius: BorderRadius.circular(6.7),
                      border: Border.all(width: 1.3, color: white)
                    ),
                    child: RaisedButton(
                      onPressed: () {

                      },
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.7)
                      ),
                      color: mainColor,
                      child: Center(
                          child: Text("로그인", style: TextStyle(
                            color: white, fontWeight: FontWeight.w600, fontSize: 14
                          ),),
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
                            height: 14,
                            color: mainColor,
                            child: Center(
                              child: Text("아이디 찾기", style: TextStyle(
                                fontSize: 12, color: white
                              ), textAlign: TextAlign.center,),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 0.7,
                        height: 11.3,
                        color: white,
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 14,
                            color: mainColor,
                            child: Center(
                              child: Text("비밀번호 찾기", style: TextStyle(
                                  fontSize: 12, color: white
                              ), textAlign: TextAlign.center,),
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
        ),
      ),
    );
  }

}
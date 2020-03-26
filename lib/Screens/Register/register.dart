import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class Register extends StatefulWidget {
  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {
  int type = 1;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController rePassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController birthDayController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyController = TextEditingController();
  TextEditingController companyNumberController = TextEditingController();
  TextEditingController repPhoneController = TextEditingController();
  TextEditingController siteController = TextEditingController();

  FocusNode passNode = FocusNode();
  FocusNode rePassNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode companyNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode birthDayNode = FocusNode();
  FocusNode companyNumberNode = FocusNode();
  FocusNode repPhoneNode = FocusNode();
  FocusNode siteNode = FocusNode();

  bool check1 = false;
  bool check2 = false;

  String apiAddress = "";

  bool checkRequired = false;
  bool checkNotRequired = false;

  File image;

  bool emailCheck = true;
  bool passCheck = true;

  String birthDay = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 32, right: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    whiteSpaceH(30),
                    Center(
                      child: Image.asset(
                        "assets/logo_color.png",
                        fit: BoxFit.fill,
                      ),
                    ),
                    whiteSpaceH(25),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 1;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 15,
                            color: white,
                            child: Center(
                              child: Text("유저 회원가입",
                                  style: type == 0
                                      ? TextStyle(
                                          color: Color(0xFFAAAAAA),
                                          fontSize: 12)
                                      : TextStyle(fontSize: 12, color: black)),
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              type = 0;
                            });
                          },
                          child: Container(
                            width: 100,
                            height: 15,
                            color: white,
                            child: Center(
                              child: Text("운영자 회원가입",
                                  style: type == 1
                                      ? TextStyle(
                                          color: Color(0xFFAAAAAA),
                                          fontSize: 12)
                                      : TextStyle(fontSize: 12, color: black)),
                            ),
                          ),
                        ),
                      ],
                    ),
                    whiteSpaceH(15),
//                    Center(
//                      child: GestureDetector(
//                        onTap: () async {
//                          image = await ImagePicker.pickImage(
//                              source: ImageSource.gallery);
//                          setState(() {});
//                        },
//                        child: Stack(
//                          children: <Widget>[
//                            ClipOval(
//                              child: Container(
//                                width: 86.7,
//                                height: 86.7,
//                                color: Color(0xFFebebeb),
//                                child: image != null
//                                    ? Image.file(image, fit: BoxFit.fill,)
//                                    : Image.asset("assets/defaultImage.png", fit: BoxFit.fill,),
//                              ),
//                            ),
//                            Positioned(
//                              bottom: 0,
//                              right: 0,
//                              child:
//                                  Image.asset("assets/register/icon_edit.png"),
//                            )
//                          ],
//                        ),
//                      ),
//                    ),
//                    whiteSpaceH(20),
//                    Center(
//                      child: Text(
//                        "프로필 이미지",
//                        style: TextStyle(fontSize: 14, color: black),
//                        textAlign: TextAlign.center,
//                      ),
//                    ),
                    whiteSpaceH(16),
                    Text(
                      "이메일",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(3),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: TextFormField(
                        controller: emailController,
                        textInputAction: TextInputAction.next,
                        style: TextStyle(fontSize: 14, color: black),
                        onChanged: (value) {
                          if (value != "" && value != null) {
                            mainBloc.setEmail(emailController.text);
                            mainBloc.checkEmail().then((value) {
                              print("emailValue : $value");
                              if (json.decode(value)['data'] == "Duplicate") {
                                setState(() {
                                  emailCheck = false;
                                });
                              } else if (json.decode(value)['data'] ==
                                  "notDuplicate") {
                                setState(() {
                                  emailCheck = true;
                                });
                              }
                            });
                          }
                        },
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(passNode);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5)),
                      ),
                    ),
                    !emailCheck ? whiteSpaceH(8) : Container(),
                    !emailCheck
                        ? Text(
                            "이미 사용중인 이메일입니다.",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFFFE9700)),
                          )
                        : Container(),
                    whiteSpaceH(15),
                    Text(
                      "비밀번호",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(3),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: TextFormField(
                        controller: passController,
                        focusNode: passNode,
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        style: TextStyle(fontSize: 14, color: black),
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(rePassNode);
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5)),
                      ),
                    ),
                    whiteSpaceH(15),
                    Text(
                      "비밀번호 확인",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(3),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: TextFormField(
                        controller: rePassController,
                        focusNode: rePassNode,
                        obscureText: true,
                        style: TextStyle(fontSize: 14, color: black),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(nameNode);
                        },
                        onChanged: (value) {
                          if (passController.text != rePassController.text) {
                            setState(() {
                              passCheck = false;
                            });
                          } else if (passController.text ==
                              rePassController.text) {
                            setState(() {
                              passCheck = true;
                            });
                          }
                        },
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5)),
                      ),
                    ),
                    !passCheck ? whiteSpaceH(8) : Container(),
                    !passCheck
                        ? Text(
                            "비밀번호가 일치하지 않습니다.",
                            style: TextStyle(
                                fontSize: 12, color: Color(0xFFFE9700)),
                          )
                        : Container(),
                    whiteSpaceH(30),
                    Text(
                      "가입자 성명",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(3),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: TextFormField(
                        controller: nameController,
                        focusNode: nameNode,
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (value) {},
                        style: TextStyle(fontSize: 14, color: black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5)),
                      ),
                    ),
                    whiteSpaceH(15),
                    Text(
                      "가입자 생년월일",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(3),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: TextFormField(
                        controller: birthDayController,
                        onTap: () {
                          DatePicker.showDatePicker(context,
                              minTime: DateTime(1930, 1, 1),
                              showTitleActions: true, onChanged: (date) {
                            setState(() {
                              if (date.month.toString().length < 2) {
                                if (date.day.toString().length < 2) {
                                  birthDay =
                                      "${date.year}-0${date.month}-0${date.day}";
                                  birthDayController.text =
                                      "${date.year}년 0${date.month}월 0${date.day}일";
                                } else {
                                  birthDay =
                                      "${date.year}-0${date.month}-${date.day}";
                                  birthDayController.text =
                                      "${date.year}년 0${date.month}월 ${date.day}일";
                                }
                              } else {
                                if (date.day.toString().length < 2) {
                                  birthDay =
                                  "${date.year}-${date.month}-0${date.day}";
                                  birthDayController.text =
                                  "${date.year}년 ${date.month}월 0${date.day}일";
                                } else {
                                  birthDay =
                                  "${date.year}-${date.month}-${date.day}";
                                  birthDayController.text =
                                  "${date.year}년 ${date.month}월 ${date.day}일";
                                }
                              }
                            });
                          }, onConfirm: (date) {
                            setState(() {
                              if (date.month.toString().length < 2) {
                                if (date.day.toString().length < 2) {
                                  birthDay =
                                  "${date.year}-0${date.month}-0${date.day}";
                                  birthDayController.text =
                                  "${date.year}년 0${date.month}월 0${date.day}일";
                                } else {
                                  birthDay =
                                  "${date.year}-0${date.month}-${date.day}";
                                  birthDayController.text =
                                  "${date.year}년 0${date.month}월 ${date.day}일";
                                }
                              } else {
                                if (date.day.toString().length < 2) {
                                  birthDay =
                                  "${date.year}-${date.month}-0${date.day}";
                                  birthDayController.text =
                                  "${date.year}년 ${date.month}월 0${date.day}일";
                                } else {
                                  birthDay =
                                  "${date.year}-${date.month}-${date.day}";
                                  birthDayController.text =
                                  "${date.year}년 ${date.month}월 ${date.day}일";
                                }
                              }
                            });
                          }, locale: LocaleType.ko);
                        },
                        readOnly: true,
                        style: TextStyle(fontSize: 14, color: black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5)),
                      ),
                    ),
                    whiteSpaceH(15),
                    Text(
                      "가입자 연락처",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(3),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: TextFormField(
                        controller: phoneController,
                        focusNode: phoneNode,
                        textInputAction: TextInputAction.next,
                        maxLength: 11,
                        style: TextStyle(fontSize: 14, color: black),
                        onFieldSubmitted: (value) {
                          if (type == 0) {
                            FocusScope.of(context).requestFocus(companyNode);
                          } else {
                            FocusScope.of(context).requestFocus(siteNode);
                          }
                        },
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            counterText: "",
                            hintText: "- 없이 입력",
                            hintStyle: TextStyle(
                                color: Color(0xFF888888), fontSize: 14),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.only(
                                left: 10, right: 10, bottom: 5)),
                      ),
                    ),
                    type == 1 ? whiteSpaceH(15) : whiteSpaceH(35),
                    type == 0
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "업체명",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              whiteSpaceH(3),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: white,
                                    border:
                                        Border.all(color: Color(0xFFDDDDDD))),
                                child: TextFormField(
                                  controller: companyController,
                                  focusNode: companyNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(companyNumberNode);
                                  },
                                  style: TextStyle(fontSize: 14, color: black),
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 5)),
                                ),
                              ),
                              whiteSpaceH(15),
                              Text(
                                "사업자등록번호",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              whiteSpaceH(3),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: white,
                                    border:
                                        Border.all(color: Color(0xFFDDDDDD))),
                                child: TextFormField(
                                  controller: companyNumberController,
                                  focusNode: companyNumberNode,
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(fontSize: 14, color: black),
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(repPhoneNode);
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                      hintText: "- 없이 입력",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF888888),
                                          fontSize: 14),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 5)),
                                ),
                              ),
                              whiteSpaceH(15),
                              Text(
                                "대표 연락처",
                                style: TextStyle(
                                    color: black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600),
                              ),
                              whiteSpaceH(3),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: white,
                                    border:
                                        Border.all(color: Color(0xFFDDDDDD))),
                                child: TextFormField(
                                  controller: repPhoneController,
                                  focusNode: repPhoneNode,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (value) {
                                    FocusScope.of(context)
                                        .requestFocus(siteNode);
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly
                                  ],
                                  maxLength: 11,
                                  style: TextStyle(fontSize: 14, color: black),
                                  decoration: InputDecoration(
                                      counterText: "",
                                      hintText: "- 없이 입력",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF888888),
                                          fontSize: 14),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 5)),
                                ),
                              ),
                              whiteSpaceH(15),
                              Row(
                                children: <Widget>[
                                  Text(
                                    "바로가기 ",
                                    style: TextStyle(
                                        color: black,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "(선택)",
                                    style: TextStyle(
                                        color: Color(0xFF888888),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              whiteSpaceH(3),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 45,
                                decoration: BoxDecoration(
                                    color: white,
                                    border:
                                        Border.all(color: Color(0xFFDDDDDD))),
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  controller: siteController,
                                  focusNode: siteNode,
                                  style: TextStyle(fontSize: 14, color: black),
                                  decoration: InputDecoration(
                                      hintText: "ex) mestory.co.kr",
                                      hintStyle: TextStyle(
                                          color: Color(0xFF888888),
                                          fontSize: 14),
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                          left: 10, right: 10, bottom: 5)),
                                ),
                              ),
                              whiteSpaceH(15),
                            ],
                          )
                        : Container(),
                    Text(
                      "주소",
                      style: TextStyle(
                          color: black,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                    whiteSpaceH(3),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 45,
                            decoration: BoxDecoration(
                                border: Border.all(color: Color(0xFFDDDDDD)),
                                color: white),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 10, bottom: 10),
                                child: Text(
                                  apiAddress,
                                  style: TextStyle(color: black, fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                        ),
                        whiteSpaceW(10),
                        Expanded(
                          flex: 2,
                          child: RaisedButton(
                            onPressed: () {},
                            color: mainColor,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              child: Center(
                                child: Text(
                                  "주소 찾기",
                                  style: TextStyle(color: white, fontSize: 14),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    whiteSpaceH(10),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 45,
                      decoration: BoxDecoration(
                        color: white,
                        border: Border.all(color: Color(0xFFDDDDDD)),
                      ),
                      child: TextFormField(
                        controller: addressController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {},
                        style: TextStyle(fontSize: 14, color: black),
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                                fontSize: 14, color: Color(0xFF888888)),
                            hintText: "나머지 주소",
                            contentPadding: EdgeInsets.only(
                                right: 10, bottom: 5, left: 10)),
                      ),
                    ),
                    whiteSpaceH(30),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              checkRequired = !checkRequired;
                            });
                          },
                          child: Image.asset(
                            checkRequired
                                ? "assets/register/icon_check_color.png"
                                : "assets/register/icon_check_grey.png",
                            width: 18,
                            height: 18,
                          ),
                        ),
                        whiteSpaceW(10),
                        Text(
                          "약관 동의 ",
                          style: TextStyle(
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "(필수)",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF02A7F2)),
                        )
                      ],
                    ),
                    whiteSpaceH(5),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 135,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: TextFormField(
                        readOnly: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                      ),
                    ),
                    whiteSpaceH(15),
                    Row(
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              checkNotRequired = !checkNotRequired;
                            });
                          },
                          child: Image.asset(
                            checkNotRequired
                                ? "assets/register/icon_check_color.png"
                                : "assets/register/icon_check_grey.png",
                            width: 18,
                            height: 18,
                          ),
                        ),
                        whiteSpaceW(10),
                        Text(
                          "광고 수신 동의 ",
                          style: TextStyle(
                              fontSize: 14,
                              color: black,
                              fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "(선택)",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: Color(0xFF888888)),
                        )
                      ],
                    ),
                    whiteSpaceH(5),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 135,
                      decoration: BoxDecoration(
                          color: white,
                          border: Border.all(color: Color(0xFFDDDDDD))),
                      child: TextFormField(
                        readOnly: true,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding:
                                EdgeInsets.only(left: 10, right: 10)),
                      ),
                    ),
                    whiteSpaceH(16),
                    RaisedButton(
                      onPressed: () {
                        register();
                      },
                      shape: RoundedRectangleBorder(),
                      color: mainColor,
                      elevation: 0.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: Center(
                          child: Text(
                            "가입하기",
                            style: TextStyle(color: white, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                    whiteSpaceH(30)
                  ],
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
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  register() {
    if (emailController.text == "" || emailController.text == null) {
      Fluttertoast.showToast(
          msg: "이메일을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (!emailController.text.contains("@") ||
        !emailController.text.contains(".")) {
      Fluttertoast.showToast(
          msg: "이메일 형식으로 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (!emailCheck) {
      Fluttertoast.showToast(
          msg: "이미 사용중인 이메일입니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if ((passController.text == "" || passController.text == null) ||
        (rePassController.text == "" || rePassController.text == null)) {
      Fluttertoast.showToast(
          msg: "비밀번호를 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (!passCheck) {
      Fluttertoast.showToast(
          msg: "비밀번호가 일치하지 않습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (nameController.text == "" || nameController.text == null) {
      Fluttertoast.showToast(
          msg: "가입자 성명을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (birthDayController.text == "" ||
        birthDayController.text == null) {
      Fluttertoast.showToast(
          msg: "생년월일을 선택해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (phoneController.text == "" || phoneController.text == null) {
      Fluttertoast.showToast(
          msg: "연락처를 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (phoneController.text.length < 9) {
      Fluttertoast.showToast(
          msg: "알맞은 전화번호를 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (type == 0 &&
        (companyController.text == "" || companyController.text == null)) {
      Fluttertoast.showToast(
          msg: "업체명을 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (type == 0 &&
        (companyNumberController.text == "" ||
            companyNumberController.text == null)) {
      Fluttertoast.showToast(
          msg: "사업자등록번호를 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (type == 0 && companyNumberController.text.length < 10) {
      Fluttertoast.showToast(
          msg: "알맞은 사업자등록번호를 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (type == 0 &&
        (repPhoneController.text == "" || repPhoneController.text == null)) {
      Fluttertoast.showToast(
          msg: "대표 연락처를 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (type == 0 && repPhoneController.text.length < 9) {
      Fluttertoast.showToast(
          msg: "알맞은 번호를 입력해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else if (!checkRequired) {
      Fluttertoast.showToast(
          msg: "약관 동의에 동의해주세요.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: black,
          textColor: white,
          fontSize: 14);
    } else {
      mainBloc.setType(type);
      mainBloc.setEmail(emailController.text);
      mainBloc.setPass(passController.text);
      mainBloc.setName(nameController.text);
      mainBloc.setBirthday(birthDay);
      mainBloc.setPhone(phoneController.text);

      if (type == 0) {
        mainBloc.setCompany(companyController.text);
        mainBloc.setCompany_number(companyNumberController.text);
        mainBloc.setRep_phone(repPhoneController.text);
        mainBloc.setSite(siteController.text);
      }

      mainBloc.insertUser().then((value) {
        print("insertUser" + value);
        if (json.decode(value)['data'] == "ok") {
          Navigator.of(context).pop();
        } else {
          Fluttertoast.showToast(
              msg: "회원가입을 실패하였습니다 잠시 후 다시 시도해주세요.",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: black,
              textColor: white,
              fontSize: 14);
        }
      }).catchError((error) {
        print("insertError : ${error}");
      });
    }
  }

  @override
  void initState() {
    super.initState();
  }
}

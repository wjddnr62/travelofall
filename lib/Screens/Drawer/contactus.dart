import 'package:flutter/material.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUs createState() => _ContactUs();
}

class _ContactUs extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFebebeb),
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: white,),
        ),
        title: Text(
          "문의하기",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16.7, color: white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              whiteSpaceH(16),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 362.7,
                color: white,
                child: Column(
                  children: <Widget>[
                    whiteSpaceH(8),
                    Row(
                      children: <Widget>[
                        whiteSpaceW(16),
                        Container(
                          width: 64,
                          child: Text(
                            "분류",
                            style: TextStyle(fontSize: 14, color: black),
                          ),
                        ),
                        whiteSpaceW(8),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 41.3,
                            color: Color(0xFFebebeb),
                            padding: EdgeInsets.only(left: 7.7, right: 7.7),
                            child: TextFormField(
                                maxLines: 1,
                                style: TextStyle(color: black, fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none)),
                          ),
                        ),
                        whiteSpaceW(16)
                      ],
                    ),
                    whiteSpaceH(8),
                    Row(
                      children: <Widget>[
                        whiteSpaceW(16),
                        Container(
                          width: 64,
                          child: Text(
                            "이메일",
                            style: TextStyle(fontSize: 14, color: black),
                          ),
                        ),
                        whiteSpaceW(8),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 41.3,
                            color: Color(0xFFebebeb),
                            padding: EdgeInsets.only(left: 7.7, right: 7.7),
                            child: TextFormField(
                                maxLines: 1,
                                style: TextStyle(color: black, fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none)),
                          ),
                        ),
                        whiteSpaceW(16)
                      ],
                    ),
                    whiteSpaceH(8),
                    Row(
                      children: <Widget>[
                        whiteSpaceW(16),
                        Container(
                          width: 64,
                          child: Text(
                            "제목",
                            style: TextStyle(fontSize: 14, color: black),
                          ),
                        ),
                        whiteSpaceW(8),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 41.3,
                            color: Color(0xFFebebeb),
                            padding: EdgeInsets.only(left: 7.7, right: 7.7),
                            child: TextFormField(
                                maxLines: 1,
                                style: TextStyle(color: black, fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none)),
                          ),
                        ),
                        whiteSpaceW(16)
                      ],
                    ),
                    whiteSpaceH(8),
                    Row(
                      children: <Widget>[
                        whiteSpaceW(16),
                        Container(
                          width: 64,
                          child: Text(
                            "문의내용",
                            style: TextStyle(fontSize: 14, color: black),
                          ),
                        ),
                        whiteSpaceW(8),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 198.7,
                            color: Color(0xFFebebeb),
                            padding: EdgeInsets.only(left: 7.7, right: 7.7),
                            child: TextFormField(
                                keyboardType: TextInputType.multiline,
                                style: TextStyle(color: black, fontSize: 14),
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    focusedBorder: InputBorder.none)),
                          ),
                        ),
                        whiteSpaceW(16)
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          Positioned.fill(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 56,
              color: mainColor,
              padding:
                  EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 12),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      elevation: 0.0,
                      color: white,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.3),),
                        child: Center(
                          child: Text(
                            "취소",
                            style: TextStyle(color: mainColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                  whiteSpaceW(5.3),
                  Expanded(
                    child: RaisedButton(
                      onPressed: () {},
                      color: white,
                      elevation: 0.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 32,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.3),
//                            color: white
                        ),
                        child: Center(
                          child: Text(
                            "문의하기",
                            style: TextStyle(color: mainColor, fontSize: 14),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class MyPage extends StatefulWidget {

  VoidCallback back;

  MyPage({Key key, this.back}) : super(key: key);

  @override
  _MyPage createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        widget.back();
        return null;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Text(mainBloc.userData.name, style: TextStyle(
                      fontSize: 16, color: black, fontWeight: FontWeight.w600
                  ),),
                ),
                whiteSpaceH(24),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 1,
                  color: Color(0xFFDDDDDD),
                ),
                whiteSpaceH(20),
                Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Text("회원구분", style: TextStyle(
                          fontWeight: FontWeight.w600, color: black, fontSize: 12
                      ),),
                    ),
                    whiteSpaceW(5),
                    Text(mainBloc.userData.type == 0 ? "운영자" : "유저", style: TextStyle(
                        fontSize: 12, color: Color(0xFF666666)
                    ),)
                  ],
                ),
                whiteSpaceH(5),
                Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Text("이메일", style: TextStyle(
                          fontWeight: FontWeight.w600, color: black, fontSize: 12
                      ),),
                    ),
                    whiteSpaceW(5),
                    Text(mainBloc.userData.email, style: TextStyle(
                        fontSize: 12, color: Color(0xFF666666)
                    ),)
                  ],
                ),
                whiteSpaceH(20),
                mainBloc.userData.type == 0 ? Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Text("업체명", style: TextStyle(
                          fontWeight: FontWeight.w600, color: black, fontSize: 12
                      ),),
                    ),
                    whiteSpaceW(5),
                    Text(mainBloc.userData.company, style: TextStyle(
                        fontSize: 12, color: Color(0xFF666666)
                    ),)
                  ],
                ) : Container(),
                mainBloc.userData.type == 0 ? whiteSpaceH(5) : Container(),
                mainBloc.userData.type == 0 ? Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Text("대표연락처", style: TextStyle(
                          fontWeight: FontWeight.w600, color: black, fontSize: 12
                      ),),
                    ),
                    whiteSpaceW(5),
                    Text(mainBloc.userData.company_number, style: TextStyle(
                        fontSize: 12, color: Color(0xFF666666)
                    ),)
                  ],
                ) : Container(),
                mainBloc.userData.type == 0 ? whiteSpaceH(5) : Container(),
                mainBloc.userData.type == 0 ? Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Text("바로가기", style: TextStyle(
                          fontWeight: FontWeight.w600, color: black, fontSize: 12
                      ),),
                    ),
                    whiteSpaceW(5),
                    Text(mainBloc.userData.site, style: TextStyle(
                        fontSize: 12, color: Color(0xFF666666)
                    ),)
                  ],
                ) : Container(),
                mainBloc.userData.type == 0 ? whiteSpaceH(5) : Container(),
                whiteSpaceH(20),
                Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Text("성명", style: TextStyle(
                          fontWeight: FontWeight.w600, color: black, fontSize: 12
                      ),),
                    ),
                    whiteSpaceW(5),
                    Text(mainBloc.userData.name, style: TextStyle(
                        fontSize: 12, color: Color(0xFF666666)
                    ),)
                  ],
                ),
                whiteSpaceH(5),
                Row(
                  children: <Widget>[
                    Container(
                      width: 80,
                      child: Text("연락처", style: TextStyle(
                          fontWeight: FontWeight.w600, color: black, fontSize: 12
                      ),),
                    ),
                    whiteSpaceW(5),
                    Text(mainBloc.userData.phone, style: TextStyle(
                        fontSize: 12, color: Color(0xFF666666)
                    ),)
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
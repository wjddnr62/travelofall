import 'package:flutter/material.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class Register extends StatefulWidget {

  int type;

  Register({Key key, this.type}) : super(key: key);

  @override
  _Register createState() => _Register();
}

class _Register extends State<Register> {

  int type = 0;

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController rePassController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController companyController = TextEditingController();

  FocusNode passNode = FocusNode();
  FocusNode rePassNode = FocusNode();
  FocusNode phoneNode = FocusNode();
  FocusNode addressNode = FocusNode();
  FocusNode companyNode = FocusNode();

  bool check1 = false;
  bool check2 = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainColor,
        centerTitle: true,
        title: Text(type == 1 ? "사용자 회원가입" : "운영자 회원가입"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: white,),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 32, right: 32),
          child: Column(
            children: <Widget>[
              whiteSpaceH(32),
              GestureDetector(
                onTap: () {},
                child: ClipOval(
                  child: Container(
                    width: 86.7,
                    height: 86.7,
                    color: Color(0xFFebebeb),
                  ),
                ),
              ),
              whiteSpaceH(8),
              Text("프로필 이미지", style: TextStyle(
                  fontSize: 14, color: black
              ), textAlign: TextAlign.center,),
              whiteSpaceH(16),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 46.7,
                decoration: BoxDecoration(
                  color: Color(0xFFebebeb),
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
              whiteSpaceH(8),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 46.7,
                decoration: BoxDecoration(
                    color: Color(0xFFebebeb),
                    borderRadius: BorderRadius.circular(6.7)
                ),
                child: TextFormField(
                  controller: passController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(rePassNode);
                  },
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
              whiteSpaceH(8),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 46.7,
                decoration: BoxDecoration(
                    color: Color(0xFFebebeb),
                    borderRadius: BorderRadius.circular(6.7)
                ),
                child: TextFormField(
                  controller: rePassController,
                  textInputAction: TextInputAction.next,
                  obscureText: true,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(companyNode);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 167, 167, 167)),
                      hintText: "비밀번호 확인",
                      contentPadding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10)),
                ),
              ),
              whiteSpaceH(8),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 46.7,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.3),
                        color: Color(0xFFebebeb)
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Text("주소", style: TextStyle(
                            color: black, fontSize: 14
                          ),),
                        ),
                      ),
                    ),
                  ),
                  whiteSpaceW(3.3),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 46.7,
                      decoration: BoxDecoration(
                        color: Color(0xFF707070),
                        borderRadius: BorderRadius.circular(6.7),
                      ),
                      child: Center(
                        child: Text("찾기", style: TextStyle(
                            color: white, fontSize: 14
                        ),),
                      ),
                    ),
                  )
                ],
              ),
              whiteSpaceH(8),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 46.7,
                decoration: BoxDecoration(
                    color: Color(0xFFebebeb),
                    borderRadius: BorderRadius.circular(6.7)
                ),
                child: TextFormField(
                  controller: addressController,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    FocusScope.of(context).requestFocus(companyNode);
                  },
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 167, 167, 167)),
                      hintText: "나머지 주소",
                      contentPadding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10)),
                ),
              ),
              type == 0 ? whiteSpaceH(8) : Container(),
              type == 0 ?
              Container(
                width: MediaQuery.of(context).size.width,
                height: 46.7,
                decoration: BoxDecoration(
                    color: Color(0xFFebebeb),
                    borderRadius: BorderRadius.circular(6.7)
                ),
                child: TextFormField(
                  controller: companyController,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 167, 167, 167)),
                      hintText: "업체명",
                      contentPadding: EdgeInsets.only(
                          top: 10, bottom: 10, left: 10)),
                ),
              ) : Container(),
              whiteSpaceH(8),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                decoration: BoxDecoration(
                    color: Color(0xFFebebeb),
                    borderRadius: BorderRadius.circular(6.7)
                )
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        check1 = value;
                      });
                    },
                    value: check1,
                  ),
                  Expanded(
                    child: Text("내용을 모두 숙지하였으므로 약관에 동의합니다.", style: TextStyle(
                      fontSize: 10.7, color: black
                    ),),
                  ),
                ],
              ),
              whiteSpaceH(8),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Color(0xFFebebeb),
                      borderRadius: BorderRadius.circular(6.7)
                  )
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    activeColor: mainColor,
                    onChanged: (value) {
                      setState(() {
                        check2 = value;
                      });
                    },
                    value: check2,
                  ),
                  Expanded(
                    child: Text("내용을 모두 숙지하였으므로 약관에 동의합니다.", style: TextStyle(
                        fontSize: 10.7, color: black
                    ),),
                  ),
                ],
              ),
              whiteSpaceH(16),
              RaisedButton(
                onPressed: () {},
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.7)
                ),
                color: mainColor,
                elevation: 0.0,
                child: Container(
                  width: 106.7,
                  height: 46.7,
                  child: Center(
                    child: Text("가입하기", style: TextStyle(
                      color: white, fontSize: 14
                    ),),
                  ),
                ),
              ),
              whiteSpaceH(86.7)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    type = widget.type;
  }

}
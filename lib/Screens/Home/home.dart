import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travelofall/Screens/Login/login.dart';
import 'package:travelofall/Screens/Map/map.dart';
import 'package:travelofall/Screens/Register/register.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  final double seoulLat = 37.557941;
  final double seoulLon = 126.982676;

  final double gyeonggiLat = 37.400647;
  final double gyeonggiLon = 127.115241;

  final double incheonLat = 37.457382;
  final double incheonLon = 126.702494;

  final double busanLat = 35.179444;
  final double busanLon = 129.075556;

  final double daeguLat = 35.871389;
  final double daeguLon = 128.601389;

  final double gwangjuLat = 35.159444;
  final double gwangjuLon = 126.8525;

  final double daejeonLat = 36.5;
  final double daejeonLon = 127.266667;

  final double woolsanLat = 35.538333;
  final double woolsanLon = 129.311389;

  final double gangwonLat = 37.784037;
  final double gangwonLon = 128.173692;

  final double gyeongbukLat = 36.25;
  final double gyeongbukLon = 128.75;

  final double gyeongnamLat = 35.25;
  final double gyeongnamLon = 128.25;

  final double chungbukLat = 36.983531;
  final double chungbukLon = 127.933819;

  final double chungnamLat = 36.688157;
  final double chungnamLon = 126.777228;

  final double jeonbukLat = 35.830112;
  final double jeonbukLon = 127.117011;

  final double jeonnamLat = 34.851215;
  final double jeonnamLon = 126.986246;

  final double jejuLat = 33.366667;
  final double jejuLon = 126.533333;

  final double koreaLat = 36;
  final double koreaLon = 128;

  List<String> imgPath = [
    'assets/domastic/seoul.png',
    'assets/domastic/gyeonggi.png',
    'assets/domastic/incheon.png',
    'assets/domastic/busan.png',
    'assets/domastic/daegu.png',
    'assets/domastic/gwangju.png',
    'assets/domastic/woolsan.png',
    'assets/domastic/daejeon.png',
    'assets/domastic/gangwon.png',
    'assets/domastic/gyeongbuk.png',
    'assets/domastic/gyeongnam.png',
    'assets/domastic/chungbuk.png',
    'assets/domastic/chungnam.png',
    'assets/domastic/jeonbuk.png',
    'assets/domastic/jeonnam.png',
    'assets/domastic/jeju.png'
  ];

  List<String> city = [
    '서울',
    '경기도',
    '인천',
    '부산',
    '대구',
    '광주',
    '울산',
    '대전/세종',
    '강원도',
    '경상북도',
    '경상남도',
    '충청북도',
    '충청남도',
    '전라북도',
    '전라남도',
    '제주도'
  ];

  registerDialog() {
    return showDialog(
//        barrierDismissible: true,
        context: context,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 133.3,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(3.3)),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register(
                                  type: 0,
                                )));
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
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Register(
                                  type: 1,
                                )));
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

//  Map<PermissionGroup, PermissionStatus> permission;

  Future<bool> permissionCheck() async {
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
    PermissionStatus permission = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.location);

    print("check: " + permission.toString());
    bool pass = false;

    if (permission == PermissionStatus.granted) {
      pass = true;
    }

    return pass;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "모두의 여행",
          style: TextStyle(
              color: white, fontWeight: FontWeight.w600, fontSize: 17),
        ),
        elevation: 0.0,
        backgroundColor: mainColor,
      ),
      drawer: Drawer(
        elevation: 0.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: white,
          child: Column(
            children: <Widget>[
              whiteSpaceH(MediaQuery.of(context).padding.top),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 80,
                color: mainColor,
                padding: EdgeInsets.only(top: 36, left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.3),
                              color: white),
                          child: Center(
                            child: Text(
                              "로그인",
                              style: TextStyle(
                                color: mainColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    whiteSpaceW(5),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          registerDialog();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.3),
                              color: mainColor,
                              border: Border.all(color: white, width: 1)),
                          child: Center(
                            child: Text(
                              "회원가입",
                              style: TextStyle(
                                color: white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              whiteSpaceH(8),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/Notice');
                },
                elevation: 0.0,
                padding: EdgeInsets.all(0),
                color: white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      whiteSpaceW(16),
                      Image.asset(
                        "assets/drawer/icon_notice.png",
                        width: 24,
                        height: 24,
                      ),
                      whiteSpaceW(32),
                      Text(
                        "공지사항",
                        style: TextStyle(fontSize: 14, color: black),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                color: white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    whiteSpaceW(16),
                    Image.asset(
                      "assets/drawer/icon_event.png",
                      width: 24,
                      height: 24,
                    ),
                    whiteSpaceW(32),
                    Text(
                      "할인/이벤트",
                      style: TextStyle(fontSize: 14, color: black),
                    )
                  ],
                ),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/ContactUs');
                },
                padding: EdgeInsets.all(0),
                elevation: 0.0,
                color: white,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 48,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      whiteSpaceW(16),
                      Image.asset(
                        "assets/drawer/icon_contact.png",
                        width: 24,
                        height: 24,
                      ),
                      whiteSpaceW(32),
                      Text(
                        "문의하기",
                        style: TextStyle(fontSize: 14, color: black),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                color: white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    whiteSpaceW(16),
                    Image.asset(
                      "assets/drawer/icon_recommend.png",
                      width: 24,
                      height: 24,
                    ),
                    whiteSpaceW(32),
                    Text(
                      "추천 축제/행사",
                      style: TextStyle(fontSize: 14, color: black),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 48,
                color: white,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    whiteSpaceW(16),
                    Image.asset(
                      "assets/drawer/icon_write.png",
                      width: 24,
                      height: 24,
                    ),
                    whiteSpaceW(32),
                    Text(
                      "운영자 게시판",
                      style: TextStyle(fontSize: 14, color: black),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Stack(
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        permissionCheck().then((value) {
                          if (value) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Map(
                                      lat: koreaLat,
                                      lon: koreaLon,
                                      type: 0,
                                      local: "전국",
                                    )));
                          }
                        });
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        color: white,
                        child: Center(
                          child: Text(
                            "전국",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: black),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 1,
                      color: mainColor,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height - 175,
                      child: Padding(
                          padding: EdgeInsets.only(
                              top: 10, bottom: 10, left: 15, right: 15),
                          child: StaggeredGridView.countBuilder(
                            crossAxisCount: 2,
                            shrinkWrap: true,
                            itemCount: city.length,
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () {
                                permissionCheck().then((value) {
                                  if (value) {
                                    if (city[index] == "서울") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: seoulLat,
                                                    lon: seoulLon,
                                                    type: 1,
                                                    local: "서울",
                                                  )));
                                    } else if (city[index] == "경기도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: gyeonggiLat,
                                                    lon: gyeonggiLon,
                                                    type: 1,
                                                    local: "경기",
                                                  )));
                                    } else if (city[index] == "인천") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: incheonLat,
                                                    lon: incheonLon,
                                                    type: 1,
                                                    local: "인천",
                                                  )));
                                    } else if (city[index] == "부산") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: busanLat,
                                                    lon: busanLon,
                                                    type: 1,
                                                    local: "부산",
                                                  )));
                                    } else if (city[index] == "대구") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: daeguLat,
                                                    lon: daeguLon,
                                                    type: 1,
                                                    local: "대구",
                                                  )));
                                    } else if (city[index] == "광주") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: gwangjuLat,
                                                    lon: gwangjuLon,
                                                    type: 1,
                                                    local: "광주",
                                                  )));
                                    } else if (city[index] == "울산") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: woolsanLat,
                                                    lon: woolsanLon,
                                                    type: 1,
                                                    local: "울산",
                                                  )));
                                    } else if (city[index] == "대전/세종") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: daejeonLat,
                                                    lon: daejeonLon,
                                                    type: 1,
                                                    local: "대전",
                                                  )));
                                    } else if (city[index] == "강원도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: gangwonLat,
                                                    lon: gangwonLon,
                                                    type: 1,
                                                    local: "강원",
                                                  )));
                                    } else if (city[index] == "경상북도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: gyeongbukLat,
                                                    lon: gyeongbukLon,
                                                    type: 1,
                                                    local: "경북",
                                                  )));
                                    } else if (city[index] == "경상남도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: gyeongnamLat,
                                                    lon: gyeongnamLon,
                                                    type: 1,
                                                    local: "경남",
                                                  )));
                                    } else if (city[index] == "충청북도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: chungbukLat,
                                                    lon: chungbukLon,
                                                    type: 1,
                                                    local: "충북",
                                                  )));
                                    } else if (city[index] == "충청남도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: chungnamLat,
                                                    lon: chungnamLon,
                                                    type: 1,
                                                    local: "충남",
                                                  )));
                                    } else if (city[index] == "전라북도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: jeonbukLat,
                                                    lon: jeonbukLon,
                                                    type: 1,
                                                    local: "전북",
                                                  )));
                                    } else if (city[index] == "전라남도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: jeonnamLat,
                                                    lon: jeonnamLon,
                                                    type: 1,
                                                    local: "전남",
                                                  )));
                                    } else if (city[index] == "제주도") {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Map(
                                                    lat: jejuLat,
                                                    lon: jejuLon,
                                                    type: 1,
                                                    local: "제주",
                                                  )));
                                    }
                                  } else {}
                                });
                              },
                              child: Stack(
                                children: <Widget>[
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(5),
                                    child: Image.asset(
                                      imgPath[index],
                                      width: MediaQuery.of(context).size.width,
                                      height: 80,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  Positioned.fill(
                                      child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      city[index],
                                      style: TextStyle(
                                          color: white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  ))
                                ],
                              ),
                            ),
                            staggeredTileBuilder: (idx) => StaggeredTile.fit(1),
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 10.0,
                          )),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 56,
                    color: mainColor,
                    child: Center(
                      child: Text(
                        "특산물 장터",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:travelofall/MyPage/myPage.dart';
import 'package:travelofall/Screens/Drawer/basedrawer.dart';
import 'package:travelofall/Screens/Home/discount_event.dart';
import 'package:travelofall/Screens/Home/reco_festivel.dart';
import 'package:travelofall/Screens/Login/login.dart';
import 'package:travelofall/Screens/Map/map.dart';
import 'package:travelofall/Screens/Register/register.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Server/Model/user.dart';
import 'package:travelofall/Util/translations.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/main.dart';
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

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey<ScaffoldState>();

  openDrawer() {
    if (_drawerKey.currentState != null) _drawerKey.currentState?.openDrawer();
  }

  int _currentIndex = 0;
  List<Widget> _bottomWidget = [];

  String local = "서울";
  double lat = 37.557941;
  double lon = 126.982676;
  int type = 1;
  String search = "";

  mapBack() {
    setState(() {
      _currentIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      key: _drawerKey,
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
//      bottomNavigationBar: BottomNavigationBar(
//        currentIndex: _currentIndex,
//        onTap: onTabTapped,
//        items: [
//          BottomNavigationBarItem(
//            icon: Image.asset(_currentIndex == 0 ? "assets/bottombar/home_select.png" : "assets/bottombar/home_non_select.png", width: 24, height: 24,),
//            title: Text("홈", style: TextStyle(
//              color: Color(0xFF888888),
//              fontSize: 10
//            ),)
//          ),
//          BottomNavigationBarItem(
//              icon: Image.asset(_currentIndex == 1 ? "assets/bottombar/map_select.png" : "assets/bottombar/map_non_select.png", width: 24, height: 24,),
//              title: Text("지도", style: TextStyle(
//                  color: Color(0xFF888888),
//                  fontSize: 10
//              ),)
//          ),
//          BottomNavigationBarItem(
//              icon: Image.asset(_currentIndex == 2 ? "assets/bottombar/discount_select.png" : "assets/bottombar/discount_non_select.png", width: 24, height: 24,),
//              title: Text("할인/이벤트", style: TextStyle(
//                  color: Color(0xFF888888),
//                  fontSize: 10
//              ),)
//          ),
//          BottomNavigationBarItem(
//              icon: Image.asset(_currentIndex == 3 ? "assets/bottombar/recomand_select.png" : "assets/bottombar/recomand_non_select.png", width: 24, height: 24,),
//              title: Text("추천행사", style: TextStyle(
//                  color: Color(0xFF888888),
//                  fontSize: 10
//              ),)
//          ),
//          BottomNavigationBarItem(
//              icon: Image.asset(_currentIndex == 4 ? "assets/bottombar/mypage_select.png" : "assets/bottombar/mypage_non_select.png", width: 24, height: 24,),
//              title: Text("마이", style: TextStyle(
//                  color: Color(0xFF888888),
//                  fontSize: 10
//              ),)
//          ),
//        ],
//      ),
      appBar: _currentIndex == 0
          ? AppBar(
              automaticallyImplyLeading: false,
              centerTitle: true,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: InkWell(
                      onTap: () {
                        openDrawer();
                      },
                      child: Image.asset(
                        "assets/drawer/drawer_menu.png",
                        width: 24,
                        height: 24,
                        color: white,
                      ),
                    ),
                  ),
                  whiteSpaceW(10),
                  Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        children: <Widget>[
                          whiteSpaceW(5),
                          Image.asset(
                            "assets/appbar/icon_search.png",
                            width: 24,
                            height: 24,
                          ),
                          whiteSpaceW(10),
                          Expanded(
                            child: TextFormField(
                              style: TextStyle(
                                  fontSize: 14, color: Color(0xFF333333)),
                              textInputAction: TextInputAction.search,
                              onFieldSubmitted: (value) {
                                setState(() {
                                  search = value;
                                  _currentIndex = 1;
                                  local = "전국";
                                  lat = koreaLat;
                                  lon = koreaLon;
                                  type = 0;

                                  mainBloc.searchText = search;

                                  GoogleMapView(
                                    local: local,
                                    lon: lon,
                                    lat: lat,
                                    type: type,
                                    search: search,
                                    back: () => mapBack(),
                                  );
                                  RestartWidget2.restartApp(context);
                                });
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color:
                                          Color.fromARGB(255, 167, 167, 167)),
                                  contentPadding:
                                      EdgeInsets.only(bottom: 10, right: 10)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  whiteSpaceW(10),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "서비스 준비 중입니다.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: black,
                            textColor: white,
                            fontSize: 14);
                      },
                      child: Image.asset(
                        "assets/appbar/icon_shop.png",
                        width: 24,
                        height: 24,
                        color: white,
                      ),
                    ),
                  ),
                ],
              ),
              elevation: 0.0,
              backgroundColor: mainColor,
            )
          : _currentIndex == 1
              ? null
//      AppBar(
//                  automaticallyImplyLeading: false,
//                  centerTitle: true,
//                  title: Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    crossAxisAlignment: CrossAxisAlignment.center,
//                    children: <Widget>[
//                      Center(
//                        child: InkWell(
//                          onTap: () {
//                            setState(() {
//                              _currentIndex = 0;
//                            });
//                          },
//                          child: Image.asset(
//                            "assets/appbar/icon_prev.png",
//                            width: 24,
//                            height: 24,
//                          ),
//                        ),
//                      ),
//                      whiteSpaceW(10),
//                      Expanded(
//                        child: Container(
//                          width: MediaQuery.of(context).size.width,
//                          height: 40,
//                          decoration: BoxDecoration(
//                              color: white,
//                              borderRadius: BorderRadius.circular(30)),
//                          child: Row(
//                            children: <Widget>[
//                              whiteSpaceW(5),
//                              Image.asset(
//                                "assets/appbar/icon_search.png",
//                                width: 24,
//                                height: 24,
//                              ),
//                              whiteSpaceW(10),
//                              Expanded(
//                                child: TextFormField(
//                                  style: TextStyle(
//                                      fontSize: 14, color: Color(0xFF333333)),
//                                  textInputAction: TextInputAction.search,
//                                  onFieldSubmitted: (value) {
//                                    setState(() {
////                            search = value;
////                            _currentIndex = 1;
////                            local = "전국";
////                            lat = koreaLat;
////                            lon = koreaLon;
////                            type = 0;
//                                    });
//                                  },
//                                  decoration: InputDecoration(
//                                      border: InputBorder.none,
//                                      hintStyle: TextStyle(
//                                          fontSize: 14,
//                                          color: Color.fromARGB(
//                                              255, 167, 167, 167)),
//                                      contentPadding: EdgeInsets.only(
//                                          bottom: 10, right: 10)),
//                                ),
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
//                      whiteSpaceW(10),
//                      Center(
//                        child: InkWell(
//                          onTap: () {
//                            openDrawer();
//                          },
//                          child: Image.asset(
//                            "assets/drawer/drawer_menu.png",
//                            width: 24,
//                            height: 24,
//                            color: white,
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                  elevation: 0.0,
//                  backgroundColor: mainColor,
//                )
              : _currentIndex == 2
                  ? AppBar(
                      backgroundColor: mainColor,
                      leading: IconButton(
                        onPressed: () {
                          setState(() {
                            _currentIndex = 0;
                          });
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          color: white,
                        ),
                      ),
                      elevation: 0.0,
                      title: Text(
                        "할인 / 이벤트",
                        style: TextStyle(
                            color: white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  : _currentIndex == 3
                      ? AppBar(
                          backgroundColor: mainColor,
                          leading: IconButton(
                            onPressed: () {
                              setState(() {
                                _currentIndex = 0;
                              });
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: white,
                            ),
                          ),
                          elevation: 0.0,
                          title: Text(
                            "추천 축제 / 행사",
                            style: TextStyle(
                                color: white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      : null,
      drawer: Drawer(
        elevation: 0.0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: white,
          child: baseDrawer(context),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Stack(
            children: <Widget>[
              _currentIndex == 0
                  ? SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
//                          GestureDetector(
//                            onTap: () {
//                              permissionCheck().then((value) {
//                                if (value) {
//                                  setState(() {
//                                    lat = koreaLat;
//                                    lon = koreaLon;
//                                    type = 0;
//                                    local = "전국";
//                                    _currentIndex = 1;
//                                  });
//                                }
//                              });
//                            },
//                            child: Container(
//                              width: MediaQuery.of(context).size.width,
//                              height: 50,
//                              color: white,
//                              child: Center(
//                                child: Text(
//                                  "전국",
//                                  textAlign: TextAlign.center,
//                                  style: TextStyle(
//                                      fontSize: 16,
//                                      fontWeight: FontWeight.w600,
//                                      color: black),
//                                ),
//                              ),
//                            ),
//                          ),
//                          Container(
//                            width: MediaQuery.of(context).size.width,
//                            height: 1,
//                            color: mainColor,
//                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height - 140,
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10, bottom: 10, left: 15, right: 15),
                                child: StaggeredGridView.countBuilder(
                                  crossAxisCount: 2,
                                  shrinkWrap: true,
                                  itemCount: city.length,
                                  itemBuilder: (context, index) =>
                                      GestureDetector(
                                    onTap: () {
                                      permissionCheck().then((value) {
                                        if (value) {
                                          if (city[index] == "서울") {
                                            setState(() {
                                              lat = seoulLat;
                                              lon = seoulLon;
                                              type = 1;
                                              local = "서울";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "경기도") {
                                            setState(() {
                                              lat = gyeonggiLat;
                                              lon = gyeonggiLon;
                                              type = 1;
                                              local = "경기";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "인천") {
                                            setState(() {
                                              lat = incheonLat;
                                              lon = incheonLon;
                                              type = 1;
                                              local = "인천";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "부산") {
                                            setState(() {
                                              lat = busanLat;
                                              lon = busanLon;
                                              type = 1;
                                              local = "부산";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "대구") {
                                            setState(() {
                                              lat = daeguLat;
                                              lon = daeguLon;
                                              type = 1;
                                              local = "대구";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "광주") {
                                            setState(() {
                                              lat = gwangjuLat;
                                              lon = gwangjuLon;
                                              type = 1;
                                              local = "광주";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "울산") {
                                            setState(() {
                                              lat = woolsanLat;
                                              lon = woolsanLon;
                                              type = 1;
                                              local = "울산";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "대전/세종") {
                                            setState(() {
                                              lat = daejeonLat;
                                              lon = daejeonLon;
                                              type = 1;
                                              local = "대전";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "강원도") {
                                            setState(() {
                                              lat = gangwonLat;
                                              lon = gangwonLon;
                                              type = 1;
                                              local = "강원";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "경상북도") {
                                            setState(() {
                                              lat = gyeongbukLat;
                                              lon = gyeonggiLon;
                                              type = 1;
                                              local = "경북";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "경상남도") {
                                            setState(() {
                                              lat = gyeongnamLat;
                                              lon = gyeongnamLon;
                                              type = 1;
                                              local = "경남";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "충청북도") {
                                            setState(() {
                                              lat = chungbukLat;
                                              lon = chungbukLon;
                                              type = 1;
                                              local = "충북";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "충청남도") {
                                            setState(() {
                                              lat = chungnamLat;
                                              lon = chungnamLon;
                                              type = 1;
                                              local = "충남";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "전라북도") {
                                            setState(() {
                                              lat = jeonbukLat;
                                              lon = jeonbukLon;
                                              type = 1;
                                              local = "전북";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "전라남도") {
                                            setState(() {
                                              lat = jeonnamLat;
                                              lon = jeonnamLon;
                                              type = 1;
                                              local = "전남";
                                              _currentIndex = 1;
                                            });
                                          } else if (city[index] == "제주도") {
                                            setState(() {
                                              lat = jejuLat;
                                              lon = jejuLon;
                                              type = 1;
                                              local = "제주";
                                              _currentIndex = 1;
                                            });
                                          }
                                        } else {}
                                      });
                                    },
                                    child: Stack(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          child: Image.asset(
                                            imgPath[index],
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        Positioned.fill(
                                            bottom: 10,
                                            left: 10,
                                            child: Align(
                                              alignment: Alignment.bottomLeft,
                                              child: Text(
                                                city[index],
                                                style: TextStyle(
                                                    color: white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                  staggeredTileBuilder: (idx) =>
                                      StaggeredTile.fit(1),
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 10.0,
                                )),
                          ),
                        ],
                      ),
                    )
                  : Container(),
              _currentIndex == 1
                  ? Container(
                      height: MediaQuery.of(context).size.height - 85,
                      child: search != ""
                          ? RestartWidget2(
                        child: GoogleMapView(
                          local: local,
                          lon: lon,
                          lat: lat,
                          type: type,
                          search: search,
                          back: () => mapBack(),
                          drawerKey: _drawerKey,
                        ),
                      )
                          : RestartWidget2(
                        child:
                          GoogleMapView(
                            local: local,
                            lon: lon,
                            lat: lat,
                            type: type,
                            search: search,
                            back: () => mapBack(),
                            drawerKey: _drawerKey,
                          )
                      ),
                    )
                  : Container(),
              _currentIndex == 2
                  ? Container(
                      height: MediaQuery.of(context).size.height - 85,
                      child: DiscountEvent(
                        back: () => mapBack(),
                      ),
                    )
                  : Container(),
              _currentIndex == 3
                  ? Container(
                      height: MediaQuery.of(context).size.height - 85,
                      child: RecoFestival(
                        back: () => mapBack(),
                      ),
                    )
                  : Container(),
              _currentIndex == 4 ? Container(
                height: MediaQuery.of(context).size.height - 85,
                child: MyPage(
                  back: () => mapBack(),
                ),
              ) : Container(),
              Positioned(
                bottom: 61,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 1,
                    color: Color(0xFFdddddd),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  color: white,
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                _currentIndex == 0
                                    ? "assets/bottombar/home_select.png"
                                    : "assets/bottombar/home_non_select.png",
                                width: 24,
                                height: 24,
                              ),
                              Text(
                                "${Translations.of(context).trans('home')}",
                                style: TextStyle(
                                    color: Color(_currentIndex == 0
                                        ? 0xFFFE9700
                                        : 0xFF888888),
                                    fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            print('blocData : ${mainBloc.selectLocal}');
                            setState(() {
                              if (mainBloc.selectLocal != null &&
                                  mainBloc.selectLocal != "") {
                                local = mainBloc.selectLocal;
                                lat = mainBloc.selectLat;
                                lon = mainBloc.selectLon;
                                type = mainBloc.selectType;
                              }
                              _currentIndex = 1;
                            });
                          },
                          child: Column(children: <Widget>[
                            Image.asset(
                              _currentIndex == 1
                                  ? "assets/bottombar/map_select.png"
                                  : "assets/bottombar/map_non_select.png",
                              width: 24,
                              height: 24,
                            ),
                            Text(
                              "${Translations.of(context).trans('map')}",
                              style: TextStyle(
                                  color: Color(_currentIndex == 1
                                      ? 0xFFFE9700
                                      : 0xFF888888),
                                  fontSize: 10),
                              overflow: TextOverflow.ellipsis,
                            )
                          ]),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _currentIndex = 2;
                            });
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                _currentIndex == 2
                                    ? "assets/bottombar/discount_select.png"
                                    : "assets/bottombar/discount_non_select.png",
                                width: 24,
                                height: 24,
                              ),
                              Text(
                                "${Translations.of(context).trans('discount/event')}",
                                style: TextStyle(
                                    color: Color(_currentIndex == 2
                                        ? 0xFFFE9700
                                        : 0xFF888888),
                                    fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
//                      Expanded(
//                        child: GestureDetector(
//                          onTap: () {
//                            setState(() {
//                              _currentIndex = 3;
//                            });
//                          },
//                          child: Column(
//                            children: <Widget>[
//                              Image.asset(
//                                _currentIndex == 3
//                                    ? "assets/bottombar/recomand_select.png"
//                                    : "assets/bottombar/recomand_non_select.png",
//                                width: 24,
//                                height: 24,
//                              ),
//                              Text(
//                                "${Translations.of(context).trans('recommendedEvent')}",
//                                style: TextStyle(
//                                    color: Color(_currentIndex == 3
//                                        ? 0xFFFE9700
//                                        : 0xFF888888),
//                                    fontSize: 10),
//                                overflow: TextOverflow.ellipsis,
//                              )
//                            ],
//                          ),
//                        ),
//                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            if (mainBloc.userData != null) {
                              setState(() {
                                _currentIndex = 4;
                              });
                            } else {
                              Fluttertoast.showToast(
                                  msg: "로그인이 필요한 서비스입니다.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: black,
                                  textColor: white,
                                  fontSize: 14);
                            }
                          },
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                _currentIndex == 4
                                    ? "assets/bottombar/mypage_select.png"
                                    : "assets/bottombar/mypage_non_select.png",
                                width: 24,
                                height: 24,
                              ),
                              Text(
                                "${Translations.of(context).trans('my')}",
                                style: TextStyle(
                                    color: Color(_currentIndex == 4
                                        ? 0xFFFE9700
                                        : 0xFF888888),
                                    fontSize: 10),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  UserData userData;
  bool loginCheck = false;

  loginState() {
    setState(() {
      loginCheck = !loginCheck;
    });
  }

  @override
  void initState() {
    super.initState();

    if (mainBloc.userData != null) {
      userData = mainBloc.userData;
      print("mainBloc : ${mainBloc.userData.email}");
//    print('userData : ${userData.email}');
      if (userData.email != null) {
        loginState();
      }
    }
  }
}

import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travelofall/DetailInfomation/detailinfomation.dart';
import 'package:travelofall/Screens/DetailSearch/detailsearch.dart';
import 'package:travelofall/Screens/Drawer/basedrawer.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Server/Model/distance.dart';
import 'package:travelofall/Server/Model/infoMation.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';
import 'package:auto_size_text/auto_size_text.dart';

// ignore: must_be_immutable
class GoogleMapView extends StatefulWidget {
  double lat;
  double lon;
  int type;
  String local;
  String search;
  VoidCallback back;
  GlobalKey<ScaffoldState> drawerKey;

  GoogleMapView(
      {Key key,
      this.lat,
      this.lon,
      this.type,
      this.local,
      this.search,
      this.back,
      this.drawerKey})
      : super(key: key);

  @override
  _Map createState() => _Map();
}

typedef Marker MarkerUpdateAction(Marker marker);

class _Map extends State<GoogleMapView> {
  GoogleMapController _controller;

  Map<MarkerId, ClusterItem> clusterItems = <MarkerId, ClusterItem>{};
  MarkerId selectedMarker;

  CameraPosition _initPosition;

  int dateMove = 0;

  DateTime nowDate = DateTime.now();
  String formatNow = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  Location location = Location();

  // 축제행사
  List<bool> festivalEvent = [true, true, true]; // 축제, 행사, 공연
  List<String> festivalEventText = ['축제', '행사', '공연'];
  bool festivalEventStatus = true;

  // 전통시장
  List<bool> traditionalMarket = [
    true,
    true,
    true,
//    true,
//    true
  ]; // 5일장, 상설시장, 야시장, 지역대표시장, 청년몰
  List<String> traditionalMarketText = ['5일장', '상설시장', '야시장',
//    '지역대표시장', '청년몰'
  ];
  bool traditionalMarketStatus = true;

  // 테마여행
  List<bool> themeTravel = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
//    true,
  ];

  List<String> themeTravelText = [
    '테마파크&놀이공원&관광단지',
    '온천스파&워터파크',
    '아쿠아리움',
    '동물원&식물원',
    '숲&공원',
    '자연휴양림',
    '전통마을',
    '고택&한옥',
    '서원&사당&향교',
    '과학관',
    '천문대',
    '박물관&전시관',
    '미술관&예술공간',
    '음악공연전시',
    '문학관',
    '벽화&문화마을',
    '산성&읍성',
    '댐&호수&유원지',
    '건축물',
    '사찰&템플스테이',
    '고대&공룡유적',
    '종교유적',
//    '간이역',
//    '다리',
//    '동굴',
//    '모노레일&레일바이크',
//    '문화재나무',
//    '미니월드',
//    '소원&기',
//    '술',
//    '안전체험',
//    '야경명소',
//    '약수&우물',
//    '엑스포',
//    '옛담',
//    '왕릉&고분',
//    '일출일몰',
//    '자연경관',
//    '전망대',
//    '정자&누각',
//    '촬영지',
//    '케이블카&스카이워크',
//    '폭포',
//    '항구',
  ];
  bool themeTravelStatus = true;

  Future<LatLng> getLocation() async {
    LatLng latLng;
    await location.getLocation().then((value) {
      latLng = LatLng(value.latitude, value.longitude);
    });

    return latLng;
  }

  int smartSet = 0;
  int smartType = 0;
  int smartEnd = 0;
  Set<Polyline> polyline = {};

  List<LatLng> latLng = List();

  smartNavigationFin() {
    return showDialog(
        barrierDismissible: true,
        context: (context),
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: white,
            child: Container(
              width: 300,
              height: 320,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        whiteSpaceH(20),
                        Text(
                          '경로선택',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceH(30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              height: 200,
                              child: ListView.builder(
                                itemBuilder: (context, idx) {
                                  return Column(
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          whiteSpaceW(20),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: ClipOval(
                                              child: Container(
                                                width: 5,
                                                height: 5,
                                                color: idx ==
                                                        distanceData.length - 1
                                                    ? mainColor
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                          whiteSpaceW(10),
                                          Flexible(
                                            child: AutoSizeText(
                                              distanceData[idx].title,
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: black,
                                                  fontWeight: FontWeight.w600),
                                              maxLines: 1,
                                              minFontSize: 10,
                                              maxFontSize: 18,
                                            ),
                                          ),
                                          whiteSpaceW(10),
//                                        (idx == distanceData.length - 1 &&
//                                                smartType == 1)
//                                            ? Container()
//                                            :
                                          Text(
                                            distanceData[idx].km.toString() +
                                                "km",
                                            style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          whiteSpaceW(20)
                                        ],
                                      ),
                                      whiteSpaceH(10)
                                    ],
                                  );
                                },
                                shrinkWrap: true,
                                itemCount: distanceData.length,
                              ),
                            )
                          ],
                        ),
                        whiteSpaceH(20),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12),
                                        bottomLeft: Radius.circular(12))),
                                child: Text(
                                  "확인",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  TextEditingController smartController = TextEditingController();

  smartNavigation() {
    return showDialog(
        barrierDismissible: true,
        context: (context),
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: white,
            child: Container(
              width: 300,
              height: 241,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        whiteSpaceH(10),
                        Text(
                          '스마트 안내',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceH(30),
                        Column(
                          children: <Widget>[
//                            Container(
//                              width: MediaQuery.of(context).size.width,
//                              height: 1,
//                              color: Color.fromRGBO(187, 187, 187, 0.7),
//                            ),
//                            Container(
//                              width: MediaQuery.of(context).size.width,
//                              height: 40,
//                              child: RaisedButton(
//                                onPressed: () {
//                                  setState(() {
//                                    pathActive = true;
//                                    smartType = 0;
//                                    Fluttertoast.showToast(
//                                        msg: "${smartSet + 1}번째 경유지를 선택해주세요.",
//                                        toastLength: Toast.LENGTH_SHORT,
//                                        gravity: ToastGravity.BOTTOM,
//                                        backgroundColor: black,
//                                        textColor: white,
//                                        fontSize: 14);
//                                    Navigator.of(context, rootNavigator: true)
//                                        .pop();
//                                  });
//                                },
//                                color: white,
//                                elevation: 1,
//                                child: Container(
//                                  child: Text("현위치로 안내"),
//                                ),
//                              ),
//                            ),
//                            whiteSpaceH(1),
//                            Container(
//                              width: MediaQuery.of(context).size.width,
//                              height: 40,
//                              child: RaisedButton(
//                                onPressed: () {
//                                  setState(() {
//                                    pathActive = true;
//                                    smartType = 1;
//                                    Fluttertoast.showToast(
//                                        msg: "${smartSet + 1}번째 경유지를 선택해주세요.",
//                                        toastLength: Toast.LENGTH_SHORT,
//                                        gravity: ToastGravity.BOTTOM,
//                                        backgroundColor: black,
//                                        textColor: white,
//                                        fontSize: 14);
//                                    Navigator.of(context, rootNavigator: true)
//                                        .pop();
//                                  });
//                                },
//                                color: white,
//                                elevation: 1,
//                                child: Container(
//                                  child: Text("목적지로 안내"),
//                                ),
//                              ),
//                            )
                            Text(
                              "경유지 개수 입력",
                              style: TextStyle(
                                  color: black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                            whiteSpaceH(10),
                            Padding(
                              padding: EdgeInsets.only(left: 20, right: 20),
                              child: TextFormField(
                                controller: smartController,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  WhitelistingTextInputFormatter.digitsOnly
                                ],
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF333333)),
                                decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: mainColor)),
                                    hintStyle: TextStyle(
                                        fontSize: 14,
                                        color:
                                            Color.fromARGB(255, 167, 167, 167)),
                                    contentPadding: EdgeInsets.zero),
                              ),
                            )
                          ],
                        ),
                        whiteSpaceH(20),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(12))),
                                child: Text(
                                  "취소",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () {
                                  if (smartController.text != "" &&
                                      smartController.text != null) {
                                    if (int.parse(smartController.text) < 1) {
                                      Fluttertoast.showToast(
                                          msg: "1이상에 숫자를 입력해주세요.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: black,
                                          textColor: white,
                                          fontSize: 14);
                                    } else {
                                      setState(() {
                                        Navigator.of(context,
                                                rootNavigator: true)
                                            .pop();
                                        smartEnd =
                                            int.parse(smartController.text) + 1;
                                        pathActive = true;
                                        smartType = 1;
                                        Fluttertoast.showToast(
                                            msg:
                                                "${smartSet + 1}번째 경유지를 선택해주세요.",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.BOTTOM,
                                            backgroundColor: black,
                                            textColor: white,
                                            fontSize: 14);
                                      });
                                    }
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "경유지 개수를 입력해주세요.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: black,
                                        textColor: white,
                                        fontSize: 14);
                                  }
                                },
                                color: mainColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12))),
                                child: Text(
                                  "확인",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  double distanceLocation;
  List<DistanceData> distanceData = List();
  var currentLocation;
  double km = 0.0;

  addPolyline() {
    setState(() {
      polyline.add(Polyline(
          polylineId: PolylineId("test"),
          color: Colors.redAccent,
          width: 5,
          points: latLng));
    });
  }

  bool loading = false;

  selectCheck(title, lat, lon) {
    return showDialog(
        barrierDismissible: true,
        context: (context),
        builder: (_) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: white,
            child: Container(
              width: 300,
              height: 241,
              decoration: BoxDecoration(
                  color: white, borderRadius: BorderRadius.circular(12)),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        whiteSpaceH(10),
                        Text(
                          '경로선택',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: black),
                        ),
                        whiteSpaceH(30),
                        Padding(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: AutoSizeText(
                            "$title을(를)",
                            minFontSize: 12,
                            maxFontSize: 20,
                            maxLines: 1,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                color: black),
                          ),
                        ),
                        whiteSpaceH(15),
                        Text(
                          "경로로 지정하시겠습니까?",
                          style: TextStyle(color: black, fontSize: 12),
                        ),
                        whiteSpaceH(20),
                      ],
                    ),
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 48,
                              child: RaisedButton(
                                onPressed: () async {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  setState(() {
                                    loading = true;
                                  });

                                  currentLocation =
                                      await location.getLocation();
                                  distanceLocation = await Geolocator()
                                      .distanceBetween(
                                          currentLocation.latitude,
                                          currentLocation.longitude,
                                          double.parse(lat),
                                          double.parse(lon));
                                  km = double.parse((double.parse(
                                              distanceLocation
                                                  .toStringAsFixed(1)) /
                                          1000)
                                      .toStringAsFixed(1));

                                  if (smartSet < smartEnd) {
                                    smartSet++;
                                  }

                                  if (smartSet < smartEnd) {
                                    distanceData.add(DistanceData(
                                        title: title,
                                        km: km,
                                        latLng: LatLng(double.parse(lat),
                                            double.parse(lon))));
                                  }

                                  if (smartSet < smartEnd &&
                                      smartSet != smartEnd - 1) {
                                    Fluttertoast.showToast(
                                        msg: "${smartSet + 1}번째 경유지를 선택해주세요.",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        backgroundColor: black,
                                        textColor: white,
                                        fontSize: 14);
                                  }

                                  if (smartSet == smartEnd - 1) {
                                    if (smartType == 0) {
                                      smartSet = 4;
                                      distanceData
                                          .sort((a, b) => a.km.compareTo(b.km));

                                      distanceData.add(DistanceData(
                                          km: distanceData.last.km,
                                          title: "현위치",
                                          latLng: LatLng(
                                              currentLocation.latitude,
                                              currentLocation.longitude)));

                                      double second;
                                      double third;

                                      for (int i = 0;
                                          i < distanceData.length;
                                          i++) {
                                        if (i == 1) {
                                          second = distanceData[i].km -
                                              distanceData[i - 1].km;
                                        }
                                        if (i == 2) {
                                          third = distanceData[i].km -
                                              distanceData[i - 1].km;
                                        }
                                      }

                                      distanceData[1].km = double.parse(
                                          second.toStringAsFixed(1));
                                      distanceData[2].km = double.parse(
                                          third.toStringAsFixed(1));

                                      latLng.add(LatLng(
                                          currentLocation.latitude,
                                          currentLocation.longitude));

                                      for (int i = 0;
                                          i < distanceData.length;
                                          i++) {
                                        latLng.add(distanceData[i].latLng);
                                        print(
                                            "현위치 : ${distanceData[i].title}, ${distanceData[i].km}");
                                      }
                                      latLng.add(LatLng(
                                          currentLocation.latitude,
                                          currentLocation.longitude));

                                      addPolyline();
                                      setState(() {
                                        loading = false;
                                      });
//                                      Navigator.of(context, rootNavigator: true)
//                                          .pop();
                                      smartNavigationFin();
                                    } else {
                                      setState(() {
                                        loading = false;
                                      });
//                                      Navigator.of(context, rootNavigator: true)
//                                          .pop();
                                      Fluttertoast.showToast(
                                          msg: "목적지를 선택해주세요.",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.BOTTOM,
                                          backgroundColor: black,
                                          textColor: white,
                                          fontSize: 14);
                                    }
                                  } else if (smartSet == smartEnd) {
                                    if (smartType == 1) {
                                      distanceData
                                          .sort((a, b) => a.km.compareTo(b.km));

                                      distanceData.add(DistanceData(
                                          title: title,
                                          km: km,
                                          latLng: LatLng(double.parse(lat),
                                              double.parse(lon))));

                                      for (int i = 0;
                                          i < distanceData.length;
                                          i++) {
                                        if (i != 0) {
                                          distanceData[i].km = double.parse(
                                              (distanceData[i].km -
                                                      distanceData[i - 1].km)
                                                  .toStringAsFixed(1));
                                        }
                                      }
                                    }

                                    latLng.add(LatLng(currentLocation.latitude,
                                        currentLocation.longitude));

                                    for (int i = 0;
                                        i < distanceData.length;
                                        i++) {
                                      print(
                                          "목적지 : ${distanceData[i].title}, ${distanceData[i].km}");
                                      latLng.add(distanceData[i].latLng);
                                    }

                                    addPolyline();
                                    setState(() {
                                      loading = false;
                                    });
//                                    Navigator.of(context, rootNavigator: true)
//                                        .pop();
                                    smartNavigationFin();
                                  } else {
                                    setState(() {
                                      loading = false;
                                    });
//                                    Navigator.of(context, rootNavigator: true)
//                                        .pop();
                                  }
                                },
                                color: Color(0xFFF7F7F8),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(12),
                                        bottomLeft: Radius.circular(12))),
                                child: Text(
                                  "확인",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: black,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ))
                ],
              ),
            ),
          );
        });
  }

  moveMyLocation() {
    getLocation().then((value) {
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: value, zoom: 12)));
      setState(() {});
    });
  }

  zoomIn() {
//    clusteringHelper.mapController
    _controller.animateCamera(CameraUpdate.zoomIn());
    setState(() {});
  }

  zoomOut() {
//    clusteringHelper.mapController
    _controller.animateCamera(CameraUpdate.zoomOut());
    setState(() {});
  }

  moveLocation(lat, lng, zoom) {
    mainBloc.selectLat = lat;
    mainBloc.selectLon = lng;
    if (zoom.toString() == "7") {
      mainBloc.selectType = 0;
    } else {
      mainBloc.selectType = 1;
    }

    _controller.animateCamera(CameraUpdate.newLatLngZoom(
        LatLng(lat, lng), double.parse(zoom.toString())));
  }

  bool getData = false;
  List<InfoMation> _info = new List();

  TextEditingController searchText = TextEditingController();

  getDataSetting({int type, String city}) async {
    print("getDataSetting");
    if (!locationCheck) {
      mainBloc.setLocal(widget.local);
    }

    mainBloc.setDate(dateMove);

    if (widget.local == "전국") {
      (searchText.text != "" && searchText.text != null)
          ? await mainBloc.getSearchInfoAll().then((data) async {
              if (json.decode(data)['result'] != 0 &&
                  json.decode(data)['data'].length != 0) {
                if (!getData) {
                  List<dynamic> valueList = await json.decode(data)['data'];

                  for (int i = 0; i < valueList.length; i++) {
                    _info.add(InfoMation(
                        no: valueList[i]['sh_no'],
                        local: valueList[i]['sh_local'],
                        local_detail: valueList[i]['sh_local_detail'],
                        code: valueList[i]['sh_code'],
                        startDate: valueList[i]['sh_startDate'],
                        endDate: valueList[i]['sh_endDate'],
                        lat: valueList[i]['sh_lat'],
                        lon: valueList[i]['sh_lon'],
                        type_big: valueList[i]['sh_type_big'],
                        type_small: valueList[i]['sh_type_small'],
                        host: valueList[i]['sh_host'],
                        title: valueList[i]['sh_title'],
                        tel: valueList[i]['sh_tel'],
                        site: valueList[i]['sh_site'],
                        search: valueList[i]['sh_search'],
                        explan: valueList[i]['sh_explan'],
                        explan2: valueList[i]['sh_explan2'],
                        etc: valueList[i]['sh_etc'],
                        good: valueList[i]['sh_good'],
                        noticeDate: valueList[i]['sh_noticeDate'],
                        special: valueList[i]['sh_special']));
                  }

                  markerAdds();

                  setState(() {
                    getData = true;
                  });
                }
              }
            })
          : await mainBloc.getInfoAll().then((data) async {
              if (json.decode(data)['result'] != 0 &&
                  json.decode(data)['data'].length != 0) {
                if (!getData) {
                  List<dynamic> valueList = await json.decode(data)['data'];

                  for (int i = 0; i < valueList.length; i++) {
                    _info.add(InfoMation(
                        no: valueList[i]['sh_no'],
                        local: valueList[i]['sh_local'],
                        local_detail: valueList[i]['sh_local_detail'],
                        code: valueList[i]['sh_code'],
                        startDate: valueList[i]['sh_startDate'],
                        endDate: valueList[i]['sh_endDate'],
                        lat: valueList[i]['sh_lat'],
                        lon: valueList[i]['sh_lon'],
                        type_big: valueList[i]['sh_type_big'],
                        type_small: valueList[i]['sh_type_small'],
                        host: valueList[i]['sh_host'],
                        title: valueList[i]['sh_title'],
                        tel: valueList[i]['sh_tel'],
                        site: valueList[i]['sh_site'],
                        search: valueList[i]['sh_search'],
                        explan: valueList[i]['sh_explan'],
                        explan2: valueList[i]['sh_explan2'],
                        etc: valueList[i]['sh_etc'],
                        good: valueList[i]['sh_good'],
                        noticeDate: valueList[i]['sh_noticeDate'],
                        special: valueList[i]['sh_special']));
                  }

                  markerAdds();

                  setState(() {
                    getData = true;
                  });
                }
              }
            });
    } else {
      (searchText.text != "" && searchText.text != null)
          ? await mainBloc.getSearchInfo().then((data) async {
              if (json.decode(data)['result'] != 0 &&
                  json.decode(data)['data'].length != 0) {
                if (!getData) {
                  List<dynamic> valueList = await json.decode(data)['data'];

                  for (int i = 0; i < valueList.length; i++) {
                    _info.add(InfoMation(
                        no: valueList[i]['sh_no'],
                        local: valueList[i]['sh_local'],
                        local_detail: valueList[i]['sh_local_detail'],
                        code: valueList[i]['sh_code'],
                        startDate: valueList[i]['sh_startDate'],
                        endDate: valueList[i]['sh_endDate'],
                        lat: valueList[i]['sh_lat'],
                        lon: valueList[i]['sh_lon'],
                        type_big: valueList[i]['sh_type_big'],
                        type_small: valueList[i]['sh_type_small'],
                        host: valueList[i]['sh_host'],
                        title: valueList[i]['sh_title'],
                        tel: valueList[i]['sh_tel'],
                        site: valueList[i]['sh_site'],
                        search: valueList[i]['sh_search'],
                        explan: valueList[i]['sh_explan'],
                        explan2: valueList[i]['sh_explan2'],
                        etc: valueList[i]['sh_etc'],
                        good: valueList[i]['sh_good'],
                        noticeDate: valueList[i]['sh_noticeDate'],
                        special: valueList[i]['sh_special']));
                  }

                  markerAdds();

                  setState(() {
                    getData = true;
                  });
                }
              }
            })
          : await mainBloc.getInfo().then((data) async {
              if (json.decode(data)['result'] != 0 &&
                  json.decode(data)['data'].length != 0) {
                if (!getData) {
                  List<dynamic> valueList = await json.decode(data)['data'];

                  for (int i = 0; i < valueList.length; i++) {
                    _info.add(InfoMation(
                        no: valueList[i]['sh_no'],
                        local: valueList[i]['sh_local'],
                        local_detail: valueList[i]['sh_local_detail'],
                        code: valueList[i]['sh_code'],
                        startDate: valueList[i]['sh_startDate'],
                        endDate: valueList[i]['sh_endDate'],
                        lat: valueList[i]['sh_lat'],
                        lon: valueList[i]['sh_lon'],
                        type_big: valueList[i]['sh_type_big'],
                        type_small: valueList[i]['sh_type_small'],
                        host: valueList[i]['sh_host'],
                        title: valueList[i]['sh_title'],
                        tel: valueList[i]['sh_tel'],
                        site: valueList[i]['sh_site'],
                        search: valueList[i]['sh_search'],
                        explan: valueList[i]['sh_explan'],
                        explan2: valueList[i]['sh_explan2'],
                        etc: valueList[i]['sh_etc'],
                        good: valueList[i]['sh_good'],
                        noticeDate: valueList[i]['sh_noticeDate'],
                        special: valueList[i]['sh_special']));
                  }

                  markerAdds();

                  setState(() {
                    getData = true;
                  });
                }
              }
            });
    }
  }

  Set<Marker> markers = {};
  Set<ClusterItem> clusters = {};

  HSVColor hsv;

  Color typeOne = Color.fromARGB(255, 253, 192, 66); // festival
  Color typeTwo = Color.fromARGB(255, 32, 149, 242); // market
  Color typeThree = Color.fromARGB(255, 120, 82, 190); // thema
  Color typeFour = Color.fromARGB(255, 254, 85, 33); // good
  Color color = Color(0xFF7852BE);

  bool touchMarker = false;
  List<String> snippet;
  InfoMation selectInfo;

  markerSelect(i, type) {
    print("markerSelect");
    setState(() {
      if (!pathActive) {
        if (!touchMarker) {
          touchMarker = !touchMarker;
        }
        selectInfo = _info[i];
        snippet =
            "${_info[i].title}¿${_info[i].local}¿${_info[i].local_detail}¿${type == 1 ? festivalEventText[_info[i].type_small - 1] : type == 2 ? traditionalMarketText[_info[i].type_small - 1] : type == 3 ? themeTravelText[_info[i].type_small - 7] : ""}"
                .split("¿");
      } else {
        if (smartSet == smartEnd) {
          if (!touchMarker) {
            touchMarker = !touchMarker;
          }
          selectInfo = _info[i];
          snippet =
              "${_info[i].title}¿${_info[i].local}¿${_info[i].local_detail}¿${type == 1 ? festivalEventText[_info[i].type_small - 1] : type == 2 ? traditionalMarketText[_info[i].type_small - 1] : type == 3 ? themeTravelText[_info[i].type_small - 7] : ""}"
                  .split("¿");
        } else {
          selectCheck(_info[i].title, _info[i].lat, _info[i].lon);
        }
      }
    });
  }

  addMarker(i, markerId, type) {
//    print("type : $type");
    if (type == 1) {
      hsv = HSVColor.fromColor(typeOne);
    } else if (type == 2) {
      hsv = HSVColor.fromColor(typeTwo);
    } else if (type == 3) {
      hsv = HSVColor.fromColor(typeThree);
    } else if (type == 4) {
      hsv = HSVColor.fromColor(typeFour);
    }

    setState(() {
      clusters.add(ClusterItem(
//          icon: BitmapDescriptor.defaultMarkerWithHue(160),
          markerId: markerId,
          position:
              LatLng(double.parse(_info[i].lat), double.parse(_info[i].lon)),
          icon: BitmapDescriptor.defaultMarkerWithHue(hsv.hue),
          visible: true,
          onTap: () {
            markerSelect(i, type);
          },
          infoWindow: InfoWindow(
              snippet:
                  "${_info[i].title}¿${_info[i].local}¿${_info[i].local_detail}¿${type == 1 ? festivalEventText[_info[i].type_small - 1] : type == 2 ? traditionalMarketText[_info[i].type_small - 1] : type == 3 ? themeTravelText[_info[i].type_small - 7] : ""}")));
//      markers.add(Marker(
//        markerId: markerId,
//        position:
//            LatLng(double.parse(_info[i].lat), double.parse(_info[i].lon)),
//        icon: BitmapDescriptor.defaultMarkerWithHue(hsv.hue),
//        onTap: () {
//          markerSelect(i, type);
//        },
//        infoWindow: InfoWindow(
//            snippet:
//                "${_info[i].title}¿${_info[i].local}¿${_info[i].local_detail}¿${type == 1 ? festivalEventText[_info[i].type_small - 1] : type == 2 ? traditionalMarketText[_info[i].type_small - 1] : type == 3 ? themeTravelText[_info[i].type_small - 7] : recommendedInformationText[_info[i].type_small - 1]}"),
//      ));
//    print(clusterItems[markerId].toString());
    });
  }

  markerAdds() {
    for (int i = 0; i < _info.length; i++) {
      final MarkerId markerId = MarkerId(i.toString());

      print("addMarker : ${_info[i].type_big}");

      if (festivalEventStatus) {
        if (_info[i].type_big == 1) {
          addMarker(i, markerId, 1);
        }
      } else {
        for (int j = 0; j < festivalEvent.length; j++) {
          if (_info[i].type_big == 1 &&
              (festivalEvent[j] && _info[i].type_small == j + 1)) {
            addMarker(i, markerId, 1);
          }
        }
      }

      if (traditionalMarketStatus) {
        if (_info[i].type_big == 2) {
          addMarker(i, markerId, 2);
        }
      } else {
        for (int j = 0; j < traditionalMarket.length; j++) {
          if (_info[i].type_big == 2 &&
              (traditionalMarket[j] && _info[i].type_small == j + 1)) {
            addMarker(i, markerId, 2);
          }
        }
      }

      if (themeTravelStatus) {
        if (_info[i].type_big == 3) {
          addMarker(i, markerId, 3);
        }
      } else {
        for (int j = 0; j < themeTravel.length; j++) {
          if (_info[i].type_big == 3 &&
              (themeTravel[j] && _info[i].type_small == j + 7)) {
            addMarker(i, markerId, 3);
          }
        }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.search != "" && widget.search != null) {
      searchText.text = widget.search;
    }

    setState(() {
      selectBoxValue = widget.local;
      mainBloc.selectLocal = widget.local;
      mainBloc.selectLat = widget.lat;
      mainBloc.selectLon = widget.lon;
      mainBloc.selectType = widget.type;
    });

    _initPosition = CameraPosition(
        target: LatLng(widget.lat, widget.lon),
        zoom: widget.type == 0 ? 7 : 12);

    getDataSetting();
  }

  optionStatusCheck(DetailSearch detailSearch) async {
    festivalEvent = detailSearch.festivalEvent;
    traditionalMarket = detailSearch.traditionalMarket;
    themeTravel = detailSearch.themeTravel;

    bool oneStatus = true;
    bool twoStatus = true;
    bool threeStatus = true;
    bool fourStatus = true;

    for (int i = 0; i < festivalEvent.length; i++) {
      if (!festivalEvent[i]) {
        oneStatus = false;
        break;
      }
    }

    festivalEventStatus = oneStatus;

    for (int i = 0; i < traditionalMarket.length; i++) {
      if (!traditionalMarket[i]) {
        twoStatus = false;
        break;
      }
    }

    traditionalMarketStatus = twoStatus;

    for (int i = 0; i < themeTravel.length; i++) {
      if (!themeTravel[i]) {
        threeStatus = false;
        break;
      }
    }

    themeTravelStatus = threeStatus;
  }

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

  String selectBoxValue = "";

  List<String> city = [
    '서울',
    '경기',
    '인천',
    '부산',
    '대구',
    '광주',
    '울산',
    '대전/세종',
    '강원',
    '경북',
    '경남',
    '충북',
    '충남',
    '전북',
    '전남',
    '제주'
  ];

  bool locationCheck = false;

  bool pathActive = false;

  openDrawer() {
    if (widget.drawerKey.currentState != null)
      widget.drawerKey.currentState?.openDrawer();
  }

  String selectDate = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        widget.back();
        return null;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: InkWell(
                  onTap: () {
                    setState(() {
                      widget.back();
                    });
                  },
                  child: Image.asset(
                    "assets/appbar/icon_prev.png",
                    width: 24,
                    height: 24,
                  ),
                ),
              ),
              whiteSpaceW(10),
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 40,
                  decoration: BoxDecoration(
                      color: white, borderRadius: BorderRadius.circular(30)),
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
                          controller: searchText,
                          style:
                              TextStyle(fontSize: 14, color: Color(0xFF333333)),
                          textInputAction: TextInputAction.search,
                          onFieldSubmitted: (value) {
                            setState(() {
                              mainBloc.setSearch(value);
                              getData = false;
                              clusters.clear();
                              markers.clear();
                              _info.clear();
                              pathActive = false;
                              distanceData.clear();
                              smartSet = 0;
                              smartType = 0;
                              latLng.clear();
                              polyline.clear();
                              getDataSetting();
                            });
                          },
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(255, 167, 167, 167)),
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
            ],
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
            child: baseDrawer(context),
          ),
        ),
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  myLocationButtonEnabled: false,
                  initialCameraPosition: _initPosition,
                  clusterItems: clusters,
                  polylines: polyline,
//                  clusterItems: Set<ClusterItem>.of(clusterItems.values),
//                  markers: markers,
//                  onCameraMove: (pos) {
//                    print("check");
//                    setState(() {});
//                  },
//                  markers: googleMarkers.toSet(),
                  onMapCreated: (GoogleMapController controller) async {
                    _controller = controller;
                  },
                ),
              ),
              MediaQuery.removePadding(
                context: context,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  color: white,
                  child: Padding(
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 80,
                                height: 30,
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    isExpanded: true,
                                    elevation: 0,
                                    style: TextStyle(color: black),
                                    items: city.map((value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Center(
                                          child: Text(
                                            value,
                                            style: TextStyle(
                                                color: Color(0xFF333333),
                                                fontSize: 12),
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                    value: selectBoxValue,
                                    onChanged: (value) {
                                      setState(() {
                                        selectBoxValue = value;
                                        mainBloc.selectLocal = value;
                                        if (value.contains("대전")) {
                                          mainBloc.setLocal("대전");
                                        } else {
                                          mainBloc.setLocal(value);
                                        }
                                        locationCheck = true;
                                        setState(() {
                                          widget.local = value;
                                          if (value == "전국") {
                                            moveLocation(koreaLat, koreaLon, 7);
                                          } else if (value == "서울") {
                                            moveLocation(
                                                seoulLat, seoulLon, 12);
                                          } else if (value == "경기") {
                                            moveLocation(
                                                gyeonggiLat, gyeonggiLon, 12);
                                          } else if (value == "인천") {
                                            moveLocation(
                                                incheonLat, incheonLon, 12);
                                          } else if (value == "부산") {
                                            moveLocation(
                                                busanLat, busanLon, 12);
                                          } else if (value == "대구") {
                                            moveLocation(
                                                daeguLat, daeguLon, 12);
                                          } else if (value == "광주") {
                                            moveLocation(
                                                gwangjuLat, gwangjuLon, 12);
                                          } else if (value == "울산") {
                                            moveLocation(
                                                woolsanLat, woolsanLon, 12);
                                          } else if (value == "대전/세종") {
                                            moveLocation(
                                                daejeonLat, daejeonLon, 12);
                                          } else if (value == "강원") {
                                            moveLocation(
                                                gangwonLat, gangwonLon, 12);
                                          } else if (value == "경북") {
                                            moveLocation(
                                                gyeongbukLat, gyeongbukLon, 12);
                                          } else if (value == "경남") {
                                            moveLocation(
                                                gyeongnamLat, gyeongnamLon, 12);
                                          } else if (value == "충북") {
                                            moveLocation(
                                                chungbukLat, chungbukLon, 12);
                                          } else if (value == "충남") {
                                            moveLocation(
                                                chungnamLat, chungnamLon, 12);
                                          } else if (value == "전북") {
                                            moveLocation(
                                                jeonbukLat, jeonbukLon, 12);
                                          } else if (value == "전남") {
                                            moveLocation(
                                                jeonnamLat, jeonnamLon, 12);
                                          } else if (value == "제주") {
                                            moveLocation(jejuLat, jejuLon, 12);
                                          }

                                          getData = false;
                                          clusters.clear();
                                          markers.clear();
                                          _info.clear();
                                          getDataSetting();
                                        });
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                height: 20,
                                color: Color(0xFFDDDDDD),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      dateMove = dateMove - 1;
                                      mainBloc.setDate(dateMove);
                                      setState(() {
                                        getData = false;
                                        clusters.clear();
                                        markers.clear();
                                        _info.clear();
                                        getDataSetting();
                                        formatNow = formatDate(
                                            DateTime.now()
                                                .add(Duration(days: dateMove)),
                                            [yyyy, '-', mm, '-', dd]);
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 30,
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_back_ios,
                                          color: Color(0xFF888888),
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    color: white,
                                    child: Center(
                                      child: Text(
                                        formatNow,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: black,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      dateMove = dateMove + 1;
                                      mainBloc.setDate(dateMove);
                                      setState(() {
                                        formatNow = formatDate(
                                            DateTime.now()
                                                .add(Duration(days: dateMove)),
                                            [yyyy, '-', mm, '-', dd]);
                                        getData = false;
                                        clusters.clear();
                                        markers.clear();
                                        _info.clear();
                                        getDataSetting();
                                      });
                                    },
                                    child: Container(
                                      width: 50,
                                      height: 30,
                                      child: Center(
                                        child: Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF888888),
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
//                              Expanded(
//                                child: Container(),
//                              ),
                              whiteSpaceW(20),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (pathActive) {
                                        pathActive = false;
                                        distanceData.clear();
                                        smartSet = 0;
                                        smartType = 0;
                                        latLng.clear();
                                        polyline.clear();
                                      } else {
                                        smartNavigation();
                                      }
                                    });
                                  },
                                  child: Image.asset(
                                    pathActive
                                        ? "assets/map/icon_path_active.png"
                                        : "assets/map/icon_path.png",
                                    color: pathActive
                                        ? mainColor
                                        : Color(0xFF333333),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(),
                              ),
                              Flexible(
                                child: InkWell(
                                  onTap: () {
                                    DatePicker.showDatePicker(context,
                                        minTime: DateTime(1930, 1, 1),
                                        showTitleActions: true,
                                        onConfirm: (date) {
                                      setState(() {
                                        if (date.month.toString().length < 2) {
                                          selectDate =
                                              "${date.year}-0${date.month}-${date.day}";
                                        } else {
                                          selectDate =
                                              "${date.year}-${date.month}-${date.day}";
                                        }
                                        int calDate = DateTime.parse(selectDate)
                                            .difference(DateTime.now())
                                            .inDays;
                                        if (calDate >= 0) {
                                          calDate += 1;
                                        }
                                        mainBloc.setDate(calDate);
                                        setState(() {
                                          getData = false;
                                          clusters.clear();
                                          markers.clear();
                                          _info.clear();
                                          pathActive = false;
                                          distanceData.clear();
                                          smartSet = 0;
                                          smartType = 0;
                                          latLng.clear();
                                          polyline.clear();
                                          getDataSetting();
                                          formatNow = formatDate(
                                              DateTime.now()
                                                  .add(Duration(days: calDate)),
                                              [yyyy, '-', mm, '-', dd]);
                                        });
                                      });
                                    }, locale: LocaleType.ko);
                                  },
                                  child: Image.asset(
                                    "assets/map/icon_calender.png",
                                    color: Color(0xFF333333),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        whiteSpaceH(5),
                        MediaQuery.removePadding(
                          context: context,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: Color(0xFFDDDDDD),
                          ),
                          removeLeft: true,
                          removeRight: true,
                        ),
                        whiteSpaceH(5),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              whiteSpaceW(5),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    festivalEventStatus = !festivalEventStatus;
                                    if (festivalEventStatus) {
                                      for (int i = 0;
                                          i < festivalEvent.length;
                                          i++) {
                                        festivalEvent[i] = true;
                                      }
                                      getData = false;
                                      clusters.clear();
                                      markers.clear();
                                      _info.clear();
                                      setState(() {
                                        getDataSetting();
                                      });
                                    } else {
                                      for (int i = 0;
                                          i < festivalEvent.length;
                                          i++) {
                                        festivalEvent[i] = false;
                                      }
                                      getData = false;
                                      clusters.clear();
                                      markers.clear();
                                      _info.clear();
                                      setState(() {
                                        getDataSetting();
                                      });
                                    }
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    festivalEventStatus
                                        ? Image.asset(
                                            "assets/map/icon_festival.png",
                                            width: 20,
                                            height: 20,
                                          )
                                        : Image.asset(
                                            "assets/map/icon_festival_default.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                    whiteSpaceW(5),
                                    Text(
                                      "축제행사",
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Color(0xFF707070)),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              whiteSpaceW(25),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    traditionalMarketStatus =
                                        !traditionalMarketStatus;
                                    if (traditionalMarketStatus) {
                                      for (int i = 0;
                                          i < traditionalMarket.length;
                                          i++) {
                                        traditionalMarket[i] = true;
                                      }
                                      getData = false;
                                      clusters.clear();
                                      markers.clear();
                                      _info.clear();
                                      setState(() {
                                        getDataSetting();
                                      });
                                    } else {
                                      for (int i = 0;
                                          i < traditionalMarket.length;
                                          i++) {
                                        traditionalMarket[i] = false;
                                      }
                                      getData = false;
                                      clusters.clear();
                                      markers.clear();
                                      _info.clear();
                                      setState(() {
                                        getDataSetting();
                                      });
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    traditionalMarketStatus
                                        ? Image.asset(
                                            "assets/map/icon_market.png",
                                            width: 20,
                                            height: 20,
                                          )
                                        : Image.asset(
                                            "assets/map/icon_market_default.png",
                                            width: 20,
                                            height: 20,
                                          ),
                                    whiteSpaceW(5),
                                    Text(
                                      "전통시장",
                                      style: TextStyle(
                                          fontSize: 8,
                                          color: Color(0xFF707070)),
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                              whiteSpaceW(25),
                              Expanded(
                                child: GestureDetector(
                                  child: Row(
                                    children: <Widget>[
                                      themeTravelStatus
                                          ? Image.asset(
                                              "assets/map/icon_thema.png",
                                              width: 20,
                                              height: 20,
                                            )
                                          : Image.asset(
                                              "assets/map/icon_thema_default.png",
                                              width: 20,
                                              height: 20,
                                            ),
                                      whiteSpaceW(5),
                                      Text(
                                        "테마여행",
                                        style: TextStyle(
                                            fontSize: 8,
                                            color: Color(0xFF707070)),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                  onTap: () {
                                    setState(() {
                                      themeTravelStatus = !themeTravelStatus;
                                      if (themeTravelStatus) {
                                        for (int i = 0;
                                            i < themeTravel.length;
                                            i++) {
                                          themeTravel[i] = true;
                                        }
                                        getData = false;
                                        clusters.clear();
                                        markers.clear();
                                        _info.clear();
                                        setState(() {
                                          getDataSetting();
                                        });
                                      } else {
                                        for (int i = 0;
                                            i < themeTravel.length;
                                            i++) {
                                          themeTravel[i] = false;
                                        }
                                        getData = false;
                                        clusters.clear();
                                        markers.clear();
                                        _info.clear();
                                        setState(() {
                                          getDataSetting();
                                        });
                                      }
                                    });
                                  },
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                    builder: (context) => DetailSearch(
                                      festivalEvent: festivalEvent,
                                      traditionalMarket: traditionalMarket,
                                      themeTravel: themeTravel,
                                    ),
                                  ))
                                      .then((detailSearch) {
                                    setState(() {
                                      optionStatusCheck(detailSearch);
                                      getData = false;
                                      clusters.clear();
                                      markers.clear();
                                      _info.clear();
                                      pathActive = false;
                                      distanceData.clear();
                                      smartSet = 0;
                                      smartType = 0;
                                      latLng.clear();
                                      polyline.clear();
                                      setState(() {
                                        getDataSetting();
                                      });
                                    });
                                  });
                                },
                                child: Row(
                                  children: <Widget>[
                                    Image.asset(
                                      "assets/map/icon_search.png",
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                removeTop: true,
              ),
              Positioned(
                child: Image.asset(
                  "assets/map/icon_location.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                ),
                right: 16,
                top: 90,
              ),
              Positioned(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      // location touch
                      moveMyLocation();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                right: 16,
                top: 90,
              ),
              Positioned(
                child: Image.asset(
                  "assets/map/icon_plus.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                ),
                right: 16,
                bottom: touchMarker ? 190 : 70,
              ),
              Positioned(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      zoomIn();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                right: 16,
                bottom: touchMarker ? 190 : 70,
              ),
              Positioned(
                child: Image.asset(
                  "assets/map/icon_minus.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.fill,
                ),
                right: 16,
                bottom: touchMarker ? 150 : 30,
              ),
              Positioned(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      zoomOut();
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                    ),
                  ),
                ),
                right: 16,
                bottom: touchMarker ? 150 : 30,
              ),
//              Positioned(
//                bottom: 75,
//                child: Container(
//                  width: MediaQuery.of(context).size.width,
//                  height: 1,
//                  color: Color(0xFFDDDDDD),
//                ),
//              ),
              Positioned(
                bottom: 0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        touchMarker = !touchMarker;
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 20,
                      color: white,
                      child: Center(
                        child: Icon(
                          touchMarker
                              ? Icons.arrow_drop_down
                              : Icons.arrow_drop_up,
                          color: black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              touchMarker
                  ? Positioned(
                      bottom: 20,
                      child: GestureDetector(
                        onTap: () async {
                          if (snippet != null)
                            await location.getLocation().then((value) async {
                              final coordinates =
                                  Coordinates(value.latitude, value.longitude);
                              var address = await Geocoder.local
                                  .findAddressesFromCoordinates(coordinates);
                              print(
                                  "${address.first.featureName}, ${address.first.addressLine}");
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => DetailInfoMation(
                                    selectInfo: selectInfo,
                                    latLng:
                                        LatLng(value.latitude, value.longitude),
                                    address: address.first.addressLine),
                              ));
                            });
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 120,
                          color: white,
                          padding: EdgeInsets.all(16),
                          child: snippet != null
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Text(
                                              snippet[0],
                                              style: TextStyle(
                                                  fontSize: 16.7,
                                                  color: black,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          color: Color(0xFF707070),
                                        )
                                      ],
                                    ),
                                    whiteSpaceH(10.7),
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          "지역 : ${snippet[1]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF707070)),
                                          textAlign: TextAlign.start,
                                        ),
                                        whiteSpaceW(15),
                                        Text(
                                          "구분 : ${snippet[3]}",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Color(0xFF707070)),
                                          textAlign: TextAlign.start,
                                        )
                                      ],
                                    ),
                                    whiteSpaceH(8),
                                    Text(
                                      "장소 : ${snippet[2]}",
                                      style: TextStyle(
                                          color: Color(0xFF707070),
                                          fontSize: 12),
                                      textAlign: TextAlign.start,
                                    )
                                  ],
                                )
                              : Center(
                                  child: Text(
                                    "마커를 선택해주세요.",
                                    style: TextStyle(
                                        fontSize: 16.7,
                                        color: black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                        ),
                      ),
                    )
                  : Container(),
              loading
                  ? Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height -
                          MediaQuery.of(context).padding.top,
                      color: Colors.black54,
                      child: Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(mainColor),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}

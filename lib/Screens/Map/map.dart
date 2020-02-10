import 'dart:convert';
import 'dart:ffi';

import 'package:clustering_google_maps/clustering_google_maps.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travelofall/Screens/DetailSearch/detailsearch.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Server/Model/infoMation.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class Map extends StatefulWidget {
  double lat;
  double lon;
  int type;
  String local;

  Map({Key key, this.lat, this.lon, this.type, this.local}) : super(key: key);

  @override
  _Map createState() => _Map();
}

class _Map extends State<Map> {
//  Completer<GoogleMapController> _controller = Completer();
  MainBloc mainBloc = MainBloc();

  GoogleMapController _controller;

  CameraPosition _initPosition;

  int dateMove = 0;

  DateTime nowDate = DateTime.now();
  String formatNow = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);

  Location location = Location();

  // 축제행사
  List<bool> festivalEvent = [true, true, true]; // 축제, 행사, 공연
  bool festivalEventStatus = true;

  // 전통시장
  List<bool> traditionalMarket = [true, true, true]; // 5일장, 상설시장, 야시장
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
    true
  ];
  bool themeTravelStatus = true;

  // 추천정보
  List<bool> recommendedInformation = [true, true, true]; // 추천행사, 할인이벤트, 지역특산물
  bool recommendedInformationStatus = true;

  Future<LatLng> getLocation() async {
    LatLng latLng;
    await location.getLocation().then((value) {
      latLng = LatLng(value.latitude, value.longitude);
    });

    return latLng;
  }

  moveMyLocation() {
    getLocation().then((value) {
//      clusteringHelper.mapController
      _controller.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(target: value, zoom: 12)));
    });
  }

  zoomIn() {
//    clusteringHelper.mapController
    _controller.animateCamera(CameraUpdate.zoomIn());
  }

  zoomOut() {
//    clusteringHelper.mapController
    _controller.animateCamera(CameraUpdate.zoomOut());
  }

  bool getData = false;
  List<InfoMation> _info = new List();

  getDataSetting() async {
    print("getDataSetting : ${widget.local}");
    mainBloc.setLocal(widget.local);

    if (widget.local == "전국") {
      await mainBloc.getInfoAll().then((data) async {
        if (json.decode(data)['result'] != 0 &&
            json.decode(data)['data'].length != 0) {
          if (!getData) {
            List<dynamic> valueList = await json.decode(data)['data'];

            print('valueList : ${valueList}');

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
      await mainBloc.getInfo().then((data) async {
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

  HSVColor hsv;

  Color typeOne = Color(0xFF6fc6ff);
  Color typeTwo = Color(0xFFff6a23);
  Color typeThree = Color(0xFFbc65ff);
  Color typeFour = Color(0xFF68c875);

  bool touchMarker = false;

  addMarker(i, markerId, type) {
    if (type == 1) {
      hsv = HSVColor.fromColor(typeOne);
    } else if (type == 2) {
      hsv = HSVColor.fromColor(typeTwo);
    } else if (type == 3) {
      hsv = HSVColor.fromColor(typeThree);
    } else if (type == 4) {
      hsv = HSVColor.fromColor(typeFour);
    }

    print("hsv : ${hsv.hue}");

    setState(() {
      markers.add(Marker(
        markerId: markerId,
        position:
            LatLng(double.parse(_info[i].lat), double.parse(_info[i].lon)),
        icon: BitmapDescriptor.defaultMarkerWithHue(hsv.hue),
        onTap: () {

        },
        infoWindow: InfoWindow(
            snippet:
                "${_info[i].title}¿${_info[i].local}¿${_info[i].local_detail}"),
      ));
    });
  }

  markerAdds() {
    for (int i = 0; i < _info.length; i++) {
      final MarkerId markerId = MarkerId(_info[i].no.toString());

      print("addMarker : ${_info[i].type_big}");

      if (festivalEventStatus) {
        if (_info[i].type_big == 1) {
          addMarker(i, markerId, 1);
        }
      } else {
        for (int i = 0; i < festivalEvent.length; i++) {
          if (_info[i].type_big == 1 &&
              (festivalEvent[i] && _info[i].type_small == i + 1)) {
            addMarker(i, markerId, 1);
          }
        }
      }

      if (traditionalMarketStatus) {
        if (_info[i].type_big == 2) {
          addMarker(i, markerId, 2);
        }
      } else {
        for (int i = 0; i < traditionalMarket.length; i++) {
          if (_info[i].type_big == 2 &&
              (traditionalMarket[i] && _info[i].type_small == i + 1)) {
            addMarker(i, markerId, 2);
          }
        }
      }

      if (themeTravelStatus) {
        if (_info[i].type_big == 3) {
          addMarker(i, markerId, 3);
        }
      } else {
        for (int i = 0; i < themeTravel.length; i++) {
          if (_info[i].type_big == 3 && (themeTravel[i] && _info[i].type_small == i + 7)) {
            addMarker(i, markerId, 3);
          }
        }
      }
    }
  }

  ClusteringHelper clusteringHelper;

  @override
  void initState() {
    super.initState();

    _initPosition = CameraPosition(
        target: LatLng(widget.lat, widget.lon),
        zoom: widget.type == 0 ? 7 : 12);

    getDataSetting();
  }

  optionStatusCheck(DetailSearch detailSearch) async {
    festivalEvent = detailSearch.festivalEvent;
    traditionalMarket = detailSearch.traditionalMarket;
    themeTravel = detailSearch.themeTravel;
    recommendedInformation = detailSearch.recommendedInformation;

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

    for (int i = 0; i < recommendedInformation.length; i++) {
      if (!recommendedInformation[i]) {
        fourStatus = false;
        break;
      }
    }

    recommendedInformationStatus = fourStatus;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: mainColor,
        title: Text(
          "모두의 여행",
          style: TextStyle(
              color: white, fontSize: 16.7, fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
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
                markers: markers,
//                onCameraMove: (newPosition) =>
//                    clusteringHelper.onCameraMove(newPosition, forceUpdate: false),
//                onCameraIdle: clusteringHelper.onMapIdle,
                onMapCreated: (GoogleMapController controller) async {
//                  clusteringHelper.mapController = controller;
//                  clusteringHelper.updateMap();
                  _controller = controller;
                },
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 64,
              color: white,
              child: Padding(
                padding:
                    EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 4),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            festivalEventStatus = !festivalEventStatus;
                            if (festivalEventStatus) {
                              for (int i = 0; i < festivalEvent.length; i++) {
                                festivalEvent[i] = true;
                              }
                              markers.clear();
                              markerAdds();
                            } else {
                              for (int i = 0; i < festivalEvent.length; i++) {
                                festivalEvent[i] = false;
                              }
                              markers.clear();
                              markerAdds();
                            }
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            festivalEventStatus
                                ? Image.asset(
                                    "assets/map/icon_festival.png",
                                    width: 35,
                                    height: 35,
                                  )
                                : Image.asset(
                                    "assets/map/icon_festival_default.png",
                                    width: 35,
                                    height: 35,
                                  ),
                            whiteSpaceH(4.3),
                            Text(
                              "축제행사",
                              style: TextStyle(
                                  fontSize: 8, color: Color(0xFF707070)),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    whiteSpaceW(24),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            traditionalMarketStatus = !traditionalMarketStatus;
                            if (traditionalMarketStatus) {
                              for (int i = 0;
                                  i < traditionalMarket.length;
                                  i++) {
                                traditionalMarket[i] = true;
                              }
                            } else {
                              for (int i = 0;
                                  i < traditionalMarket.length;
                                  i++) {
                                traditionalMarket[i] = false;
                              }
                            }
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            traditionalMarketStatus
                                ? Image.asset(
                                    "assets/map/icon_market.png",
                                    width: 35,
                                    height: 35,
                                  )
                                : Image.asset(
                                    "assets/map/icon_market_default.png",
                                    width: 35,
                                    height: 35,
                                  ),
                            whiteSpaceH(4.3),
                            Text(
                              "전통시장",
                              style: TextStyle(
                                  fontSize: 8, color: Color(0xFF707070)),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    whiteSpaceW(24),
                    Expanded(
                      child: GestureDetector(
                        child: Column(
                          children: <Widget>[
                            themeTravelStatus
                                ? Image.asset(
                                    "assets/map/icon_thema.png",
                                    width: 35,
                                    height: 35,
                                  )
                                : Image.asset(
                                    "assets/map/icon_thema_default.png",
                                    width: 35,
                                    height: 35,
                                  ),
                            whiteSpaceH(4.3),
                            Text(
                              "테마여행",
                              style: TextStyle(
                                  fontSize: 8, color: Color(0xFF707070)),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        onTap: () {
                          setState(() {
                            themeTravelStatus = !themeTravelStatus;
                            if (themeTravelStatus) {
                              for (int i = 0; i < themeTravel.length; i++) {
                                themeTravel[i] = true;
                              }
                            } else {
                              for (int i = 0; i < themeTravel.length; i++) {
                                themeTravel[i] = false;
                              }
                            }
                          });
                        },
                      ),
                    ),
                    whiteSpaceW(24),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            recommendedInformationStatus =
                                !recommendedInformationStatus;
                            if (recommendedInformationStatus) {
                              for (int i = 0;
                                  i < recommendedInformation.length;
                                  i++) {
                                recommendedInformation[i] = true;
                              }
                            } else {
                              for (int i = 0;
                                  i < recommendedInformation.length;
                                  i++) {
                                recommendedInformation[i] = false;
                              }
                            }
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            recommendedInformationStatus
                                ? Image.asset(
                                    "assets/map/icon_good.png",
                                    width: 35,
                                    height: 35,
                                  )
                                : Image.asset(
                                    "assets/map/icon_good_default.png",
                                    width: 35,
                                    height: 35,
                                  ),
                            whiteSpaceH(4.3),
                            Text(
                              "추천",
                              style: TextStyle(
                                  fontSize: 8, color: Color(0xFF707070)),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                    ),
                    whiteSpaceW(24),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(
                            builder: (context) => DetailSearch(
                              festivalEvent: festivalEvent,
                              traditionalMarket: traditionalMarket,
                              themeTravel: themeTravel,
                              recommendedInformation: recommendedInformation,
                            ),
                          ))
                              .then((detailSearch) {
                            setState(() {
                              optionStatusCheck(detailSearch);
                            });
                          });
                        },
                        child: Column(
                          children: <Widget>[
                            Image.asset(
                              "assets/map/icon_search.png",
                              width: 35,
                              height: 35,
                            ),
                            whiteSpaceH(4.3),
                            Text(
                              "상세검색",
                              style: TextStyle(
                                  fontSize: 8, color: Color(0xFF707070)),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              child: Image.asset(
                "assets/map/icon_calender.png",
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
              left: 16,
              top: 72,
            ),
            Positioned(
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    // calender touch
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              left: 16,
              top: 72,
            ),
            Positioned.fill(
                child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(
                  top: 72,
                ),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            dateMove = dateMove - 1;
                            setState(() {
                              formatNow = formatDate(
                                  DateTime.now().add(Duration(days: dateMove)),
                                  [yyyy, '-', mm, '-', dd]);
                            });
                          },
                          child: Image.asset(
                            "assets/map/icon_larrow.png",
                            width: 24,
                            height: 24,
                          ),
                        ),
                        Container(
                          width: 80,
                          height: 24,
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
                            setState(() {
                              formatNow = formatDate(
                                  DateTime.now().add(Duration(days: dateMove)),
                                  [yyyy, '-', mm, '-', dd]);
                            });
                          },
                          child: Image.asset(
                            "assets/map/icon_rarrow.png",
                            width: 24,
                            height: 24,
                          ),
                        )
                      ],
                    ),
                    whiteSpaceH(8),
                    Stack(
                      children: <Widget>[
                        Container(
                          width: 80,
                          height: 24,
                          color: white,
                          child: Center(
                            child: Text(
                              "지역선택",
                              style: TextStyle(color: black, fontSize: 12),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              // 지역 선택
                            },
                            child: Container(
                              width: 80,
                              height: 24,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
            Positioned(
              child: Image.asset(
                "assets/map/icon_location.png",
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
              right: 16,
              top: 72,
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
              top: 72,
            ),
            Positioned(
              child: Image.asset(
                "assets/map/icon_plus.png",
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
              right: 16,
              bottom: 168,
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
              bottom: 168,
            ),
            Positioned(
              child: Image.asset(
                "assets/map/icon_minus.png",
                width: 40,
                height: 40,
                fit: BoxFit.fill,
              ),
              right: 16,
              bottom: 128,
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
              bottom: 128,
            ),
          ],
        ),
      ),
    );
  }
}

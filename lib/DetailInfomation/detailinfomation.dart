import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:travelofall/DetailInfomation/review.dart';
import 'package:travelofall/Server/Bloc/mainBloc.dart';
import 'package:travelofall/Server/Model/infoMation.dart';
import 'package:travelofall/Util/translations.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:travelofall/Server/Model/review.dart';

class DetailInfoMation extends StatefulWidget {
  InfoMation selectInfo;
  LatLng latLng;
  String address;

  DetailInfoMation({Key key, this.selectInfo, this.latLng, this.address}) : super(key: key);

  @override
  _DetailInfoMation createState() => _DetailInfoMation();
}

class _DetailInfoMation extends State<DetailInfoMation>
    with TickerProviderStateMixin {
  InfoMation selectInfo;
  ScrollController scrollController = ScrollController();
  bool scrolling = false;

  bool tabs = false;

  GoogleMapController _controller;
  CameraPosition _initPosition;

  scrollListener() {
    if (scrollController.offset <= scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      print('top');
      setState(() {
        scrolling = !scrolling;
      });
    }
  }

  onStartScroll(metrics) {
    setState(() {
      scrolling = !scrolling;
    });
  }

  Set<Marker> markers = {};

  StorageReference storageReference;
  FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  String mainSub = "images/shop_main/";
  List<String> numbers = ['-1.jpg', '-2.jpg', '-3.jpg', '-4.jpg', '-5.jpg'];
  List<String> images = List();

  storageGet(code) async {
    for (int i = 0; i < numbers.length; i++) {
      bool check = false;
      storageReference =
          _firebaseStorage.ref().child(mainSub + code + numbers[i]);
      await storageReference.getDownloadURL().then((value) {
        print("downloadUrl : " + value);
        setState(() {
          images.add(value);
        });
      }).catchError((error) {
        print("error");
        check = true;
      });
      if (check) {
        break;
      }
    }
  }

  int offset = 0;
  bool firstData = false;
  List<ReviewData> reviewData = List();
  List<int> page = List();

  reviewSelect(no, offset) {
      mainBloc.setNo(no);
      mainBloc.setOffset(offset);
      mainBloc.reviewSelect().then((value) async {
        if (json.decode(value)['result'] != 0 && (json.decode(value)['data'] != null && json.decode(value)['data'] != "" && json.decode(value)['data'].length != 0)) {
          if (!firstData) {
            List<dynamic> valueList = await json.decode(value)['data'];
            if (valueList.length != 0) {
              for (int i = 0; i < valueList.length; i++) {
                reviewData.add(ReviewData(
                    distance: valueList[i]['distance'],
                    reviewReturn: ReviewReturn(
                        idx: valueList[i]['reviewReturn']['idx'],
                        rvContent: valueList[i]['reviewReturn']['rv_content'],
                        rvRating: valueList[i]['reviewReturn']['rv_rating'],
                        rvDate: valueList[i]['reviewReturn']['rv_date'],
                        name: valueList[i]['reviewReturn']['name'],
                        shNo: valueList[i]['reviewReturn']['sh_no']
                    ),
                    like: valueList[i]['like'],
                    noLike: valueList[i]['noLike'],
                    allCount: valueList[i]['allCount'],
                    selectPage: valueList[i]['selectPage']
                ));
              }



            }
           }
        }
      });

  }

  bool dateView = false;

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    super.initState();

    selectInfo = widget.selectInfo;

    DateTime date = DateTime.parse(selectInfo.startDate);

    if (date.year.toString().contains("19")) {
      setState(() {
        dateView = false;
      });
    } else {
      setState(() {
        dateView = true;
      });
    }

    storageGet(selectInfo.code);

    _initPosition = CameraPosition(
        target:
            LatLng(double.parse(selectInfo.lat), double.parse(selectInfo.lon)),
        zoom: 14);

    markers.add(Marker(
      markerId: MarkerId("id"),
      position:
          LatLng(double.parse(selectInfo.lat), double.parse(selectInfo.lon)),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
    ));
  }

  detailInfo() {
    return Container(
      color: white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            selectInfo.explan,
            style: TextStyle(fontSize: 14),
          ),
          whiteSpaceH(20),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: Color(0xFFDDDDDD),
          ),
          whiteSpaceH(20),
          Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  selectInfo.local_detail,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () {
                  List<String> splits = widget.address.split(" ");
                  String address = "";
                  for (int i = 0; i < splits.length; i++) {
                    if (i != 0) {
                      address += splits[i] + " ";
                    }
                  }
                  launch("http://m.map.naver.com/route.nhn?menu=route&sname="+address+"&sx="+widget.latLng.latitude.toString()+"&sy="+widget.latLng.longitude.toString()+"&ename="+selectInfo.title+"&ex="+selectInfo.lat+"&ey="+selectInfo.lon+"&pathType=0&showMap=true");
                },
                child: Container(
//                  width: 100,
                  height: 20,
                  color: white,
                  child: Text(
                    "길찾기",
                    style: TextStyle(fontSize: 14, color: Color(0xFF02A7F2)),
                  ),
                ),
              )
            ],
          ),
          whiteSpaceH(10),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 160,
            child: GoogleMap(
              mapType: MapType.normal,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              initialCameraPosition: _initPosition,
              markers: markers,
              onMapCreated: (GoogleMapController controller) async {
                _controller = controller;
              },
            ),
          )
        ],
      ),
    );
  }

  review() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        whiteSpaceH(10),
        Center(
          child: Text(
            "평가 및 리뷰",
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: mainColor),
          ),
        ),
        whiteSpaceH(5),
        Center(
          child: Text(
            "0.0",
            style: TextStyle(
                color: mainColor, fontSize: 40, fontWeight: FontWeight.w600),
          ),
        ),
        whiteSpaceH(5),
        Center(
          child: RatingBar(
            glow: false,
            ignoreGestures: true,
            initialRating: 0.0,
            minRating: 0,
            direction: Axis.horizontal,
            allowHalfRating: false,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 1),
            ratingWidget: RatingWidget(
                full: Image.asset(
                  "assets/detail/star_full.png",
                  width: 14,
                  height: 14,
                ),
                half: null,
                empty: Image.asset(
                  "assets/detail/star_empty.png",
                  width: 14,
                  height: 14,
                )),
            tapOnlyMode: false,
            itemSize: 14,
            maxRating: 5,
            onRatingUpdate: (rating) {
              print(rating);
            },
          ),
        ),
        whiteSpaceH(5),
        Row(
          children: <Widget>[
            Expanded(
              child: Container(),
            ),
            GestureDetector(
              onTap: () {
                if (mainBloc.userData != null) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => Review(
                      title: selectInfo.title,
                      shNo: selectInfo.no,
                    ),
                  ));
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
              child: Container(
                width: 60,
                height: 20,
                child: Center(
                  child: Text(
                    "리뷰작성",
                    style: TextStyle(fontSize: 12, color: Color(0xFF02A7F2)),
                  ),
                ),
              ),
            )
          ],
        ),
        whiteSpaceH(12),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          color: Color(0xFFDDDDDD),
        ),
        whiteSpaceH(20),
        Container(
          height: 415,
          child: Center(
            child: Text(
              "표시할 리뷰가 없습니다",
              style: TextStyle(
                  color: black, fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ),
        )
      ],
    );
  }

  int idx = 1;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: mainColor,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
        title: Text(
          "${selectInfo.local} / ${selectInfo.title}",
          style: TextStyle(color: white, fontSize: 14),
        ),
        actions: <Widget>[
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/detail/icon_share.png",
              color: white,
              width: 24,
              height: 24,
            ),
          ),
          whiteSpaceW(10),
          InkWell(
            onTap: () {},
            child: Image.asset(
              "assets/detail/icon_like.png",
              color: white,
              width: 24,
              height: 24,
            ),
          ),
          whiteSpaceW(10)
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AnimatedSize(
            vsync: this,
            duration: Duration(milliseconds: 1000),
            curve: Curves.fastOutSlowIn,
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: white,
              child: Column(
                children: <Widget>[
                  scrolling
                      ? Container()
                      : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 325,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 200,
                                  child: images.length != 0
                                      ? Stack(
                                          children: <Widget>[
                                            Swiper(
                                              itemCount: images.length,
                                              itemBuilder: (context, idx) {
                                                return CachedNetworkImage(
                                                  imageUrl: images[idx],
                                                  fit: BoxFit.fill,
                                                  placeholder: (context, url) =>
                                                      Container(
                                                    child: Center(
                                                      child:
                                                          CircularProgressIndicator(
                                                        valueColor:
                                                            AlwaysStoppedAnimation<
                                                                    Color>(
                                                                mainColor),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                              onIndexChanged: (idx) {
                                                print("idx : $idx");
                                                setState(() {
                                                  this.idx = idx + 1;
                                                });
                                              },
                                            ),
                                            Positioned(
                                              top: 10,
                                              right: 10,
                                              child: Container(
                                                width: 36,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: Color.fromRGBO(
                                                        0, 0, 0, 0.6),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            3)),
                                                padding: EdgeInsets.only(
                                                    left: 6, right: 6),
                                                child: Center(
                                                  child: Text(
                                                    "$idx / ${images.length}",
                                                    style: TextStyle(
                                                        color: white,
                                                        fontSize: 10),
                                                  ),
                                                ),
                                              ),
                                            )
                                          ],
                                        )
                                      : Container(
                                          height: 200,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      mainColor),
                                            ),
                                          ),
                                        )
//                                Image.asset(
//                                  "assets/test.png",
//                                  fit: BoxFit.fill,
//                                ),
                                  ),
                              Flexible(
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
//                                height: 114,
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        selectInfo.title,
                                        style: TextStyle(
                                            color: black,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 24),
                                      ),
                                      whiteSpaceH(15),
                                      dateView ? Text(
                                        selectInfo.startDate +
                                            " ~ " +
                                            selectInfo.endDate,
                                        style: TextStyle(fontSize: 12),
                                      ) : Container(),
                                      whiteSpaceH(3),
                                      Text(
                                        selectInfo.local_detail,
                                        style: TextStyle(fontSize: 12),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 1,
                                color: Color(0xFFDDDDDD),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (scrollController.offset <=
                        scrollController.position.minScrollExtent &&
                    !scrollController.position.outOfRange) {
                  if (scrolling) {
                    if (notification is ScrollStartNotification) {
                      print('start');
                      onStartScroll(notification.metrics);
                    }
                  }
                } else {
                  print('start2');
                  if (!scrolling) {
                    setState(() {
                      scrolling = true;
                    });
                  }
                }
                return null;
              },
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 52,
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                top: scrolling ? 40 : 20,
                                left: 20,
                                right: 20,
                                bottom: 20),
                            child: MediaQuery.removePadding(
                              context: context,
                              child: Stack(
                                children: <Widget>[
                                  !tabs
                                      ? detailInfo()
                                      : Center(
                                          child: review(),
                                        ),
                                ],
                              ),
                              removeTop: true,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 20,
                            color: Color(0xFFDDDDDD),
                          ),
                          Padding(
                            padding: EdgeInsets.all(20),
                            child: Stack(
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      selectInfo.title,
                                      style: TextStyle(
                                          color: black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    whiteSpaceH(20),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          child: Text(
                                            "기간",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: black,
                                            ),
                                          ),
                                        ),
                                        whiteSpaceW(16),
                                        Text(
                                          "${selectInfo.startDate} ~ ${selectInfo.endDate}",
                                          style: TextStyle(
                                              color: Color(0xFF666666),
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                    whiteSpaceH(5),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          child: Text(
                                            "주소",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: black,
                                            ),
                                          ),
                                        ),
                                        whiteSpaceW(16),
                                        Text(
                                          "${selectInfo.local_detail}",
                                          style: TextStyle(
                                              color: Color(0xFF666666),
                                              fontSize: 12),
                                        )
                                      ],
                                    ),
                                    whiteSpaceH(5),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          child: Text(
                                            "연락처",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: black,
                                            ),
                                          ),
                                        ),
                                        whiteSpaceW(16),
                                        GestureDetector(
                                          onTap: () {
                                            if (selectInfo.tel != "") {
                                              List<String> split =
                                                  selectInfo.tel.split("-");
                                              launch(
                                                  "tel:${split[0]}${split[1]}${split[2]}");
                                            }
                                          },
                                          child: Text(
                                            selectInfo.tel != ""
                                                ? "${selectInfo.tel}"
                                                : "연락처 정보 없음",
                                            style: TextStyle(
                                                color: Color(0xFF666666),
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                    whiteSpaceH(5),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 60,
                                          child: Text(
                                            "바로가기",
                                            style: TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 12,
                                              color: black,
                                            ),
                                          ),
                                        ),
                                        whiteSpaceW(16),
                                        GestureDetector(
                                          onTap: () async {
                                            if (selectInfo.site != "")
                                              await launch(selectInfo.site);
                                          },
                                          child: Text(
                                            selectInfo.site != ""
                                                ? "${selectInfo.site}"
                                                : "바로가기 정보 없음",
                                            style: TextStyle(
                                                color: Color(0xFF666666),
                                                fontSize: 12),
                                          ),
                                        )
                                      ],
                                    ),
                                    whiteSpaceH(30),
                                    RaisedButton(
                                      onPressed: () async {
                                        if (selectInfo.search != null &&
                                            selectInfo.search != "") {
                                          await launch(
                                              "https://search.naver.com/search.naver?sm=top_hty&fbm=0&ie=utf8&query=${selectInfo.search}");
                                        } else {
                                          Fluttertoast.showToast(
                                              msg: "네이버 검색 정보가 없습니다",
                                              toastLength: Toast.LENGTH_SHORT,
                                              gravity: ToastGravity.BOTTOM,
                                              backgroundColor: mainColor,
                                              textColor: white,
                                              fontSize: 14);
                                        }
                                      },
                                      color: mainColor,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 50,
                                        child: Center(
                                          child: Text(
                                            "네이버 검색 결과 보기",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  child: ClipOval(
                                    child: Container(
                                      width: 32,
                                      height: 32,
                                      color: Color.fromRGBO(0, 0, 0, 0.6),
                                      child: Center(
                                        child: Icon(
                                          Icons.keyboard_arrow_up,
                                          color: white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  right: 0,
                                  bottom: 80,
                                ),
                                Positioned(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        scrollController.jumpTo(0.0);
                                      },
                                      child: Container(
                                        width: 32,
                                        height: 32,
                                      ),
                                    ),
                                  ),
                                  right: 0,
                                  bottom: 80,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: white,
                    height: 52,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 20, right: 20),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (tabs) {
                                        tabs = false;
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: white,
                                    width: MediaQuery.of(context).size.width,
                                    height: 51,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          color: white,
                                          child: Center(
                                            child: Text(
                                              "${Translations.of(context).trans('detailedInformation')}",
                                              style: TextStyle(
                                                  color: !tabs
                                                      ? Color(0xFFFE9700)
                                                      : black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        !tabs
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 1,
                                                color: Color(0xFFFE9700),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (!tabs) {
                                        tabs = true;
                                      }
                                    });
                                  },
                                  child: Container(
                                    color: white,
                                    width: MediaQuery.of(context).size.width,
                                    height: 51,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          height: 50,
                                          color: white,
                                          child: Center(
                                            child: Text(
                                              "${Translations.of(context).trans('review')}",
                                              style: TextStyle(
                                                  color: tabs
                                                      ? Color(0xFFFE9700)
                                                      : black,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        tabs
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 1,
                                                color: Color(0xFFFE9700),
                                              )
                                            : Container()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: Color(0xFFDDDDDD),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

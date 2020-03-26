import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

// ignore: must_be_immutable
class DetailSearch extends StatefulWidget {
  List<bool> festivalEvent;
  List<bool> traditionalMarket;
  List<bool> themeTravel;

  DetailSearch(
      {Key key,
      this.festivalEvent,
      this.traditionalMarket,
      this.themeTravel})
      : super(key: key);

  @override
  _DetailSearch createState() => _DetailSearch();
}

class _DetailSearch extends State<DetailSearch> {
  // 축제행사
  List<bool> festivalEvent = [false, false, false]; // 축제, 행사, 공연
  List<String> festivalEventText = ['축제', '행사', '공연'];

  // 전통시장
  List<bool> traditionalMarket = [false, false, false]; // 5일장, 상설시장, 야시장
  List<String> traditionalMarketText = ['5일장', '상설시장', '야시장'];

  // 테마여행
  List<bool> themeTravel = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
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
  ];

  DetailSearch detailSearchList;

  getOptionData() {
    setState(() {
      festivalEvent = widget.festivalEvent;
      traditionalMarket = widget.traditionalMarket;
      themeTravel = widget.themeTravel;
    });
  }

  @override
  void initState() {
//    SchedulerBinding.instance.addPostFrameCallback((_) => getOptionData());
    super.initState();

    getOptionData();
  }

  allSelect(type) {
    if (type == 0) {
      for (int i = 0; i < festivalEvent.length; i++) {
        setState(() {
          festivalEvent[i] = true;
        });
      }
    } else if (type == 1) {
      for (int i = 0; i < traditionalMarket.length; i++) {
        setState(() {
          traditionalMarket[i] = true;
        });
      }
    } else if (type == 2) {
      for (int i = 0; i < themeTravel.length; i++) {
        setState(() {
          themeTravel[i] = true;
        });
      }
    }
  }

  allSelectRelease(type) {
    if (type == 0) {
      for (int i = 0; i < festivalEvent.length; i++) {
        setState(() {
          festivalEvent[i] = false;
        });
      }
    } else if (type == 1) {
      for (int i = 0; i < traditionalMarket.length; i++) {
        setState(() {
          traditionalMarket[i] = false;
        });
      }
    } else if (type == 2) {
      for (int i = 0; i < themeTravel.length; i++) {
        setState(() {
          themeTravel[i] = false;
        });
      }
    }
  }

  allSelectButton(type) {
    return Container(
      width: 50,
      height: 30,
      child: RaisedButton(
        onPressed: () {
          allSelect(type);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.7)),
        color: mainColor,
        child: Container(
//        height: 20,
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Center(
            child: Text("전체 선택", style: TextStyle(
                color: white, fontSize: 12
            ),),
          ),
        ),
      ),
    );
  }

  allSelectReleaseButton(type) {
    return Container(
      width: 50,
      height: 30,
      child: RaisedButton(
        onPressed: () {
          allSelectRelease(type);
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6.7)),
        color: Color(0xFF888888),
        child: Container(
//        height: 20,
          padding: EdgeInsets.only(left: 5, right: 5),
          child: Center(
            child: Text("전체 해제", style: TextStyle(
                color: white, fontSize: 12
            ),),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: white,
      body: WillPopScope(
        onWillPop: () {
          detailSearchList = DetailSearch(
            festivalEvent: festivalEvent,
            traditionalMarket: traditionalMarket,
            themeTravel: themeTravel,
          );
          Navigator.of(context).pop(detailSearchList);

          return null;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              whiteSpaceH(20 + MediaQuery.of(context).padding.top),
              Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        detailSearchList = DetailSearch(
                          festivalEvent: festivalEvent,
                          traditionalMarket: traditionalMarket,
                          themeTravel: themeTravel,
                        );
                        Navigator.of(context).pop(detailSearchList);
                      },
                      icon: Icon(Icons.close),
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    InkWell(
                      onTap: () {
                        detailSearchList = DetailSearch(
                          festivalEvent: festivalEvent,
                          traditionalMarket: traditionalMarket,
                          themeTravel: themeTravel,
                        );
                        Navigator.of(context).pop(detailSearchList);
                      },
                      child: Container(
                        width: 30,
                        height: 30,
                        child: Text("완료",  style: TextStyle(
                            fontSize: 14,
                            color: Color(0xFF02A7F2)
                        ),),
                      ),
                    )
                  ],
                ),
              ),
              whiteSpaceH(35),
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("상세검색", style: TextStyle(
                      color: black, fontSize: 24, fontWeight: FontWeight.w600
                    ),),
                    whiteSpaceH(25),
                    Row(
                      children: <Widget>[
                        Image.asset("assets/map/icon_festival.png", width: 36, height: 36,),
                        whiteSpaceW(15),
                        Text("축제행사", style: TextStyle(
                            fontSize: 14, color: black
                        ),),
                        whiteSpaceW(10),
                        Expanded(
                          child: allSelectButton(0),
                        ),
                        whiteSpaceW(10),
                        Expanded(
                          child: allSelectReleaseButton(0),
                        )
                      ],
                    ),
                    StaggeredGridView.countBuilder(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      itemCount: festivalEvent.length,
                      itemBuilder: (context, idx) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              festivalEvent[idx] = !festivalEvent[idx];
                            });
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: festivalEvent[idx]
                                  ? Color(0xFFFE9700)
                                  : Color(0xFFE3E3E3),
                            ),
                            child: Center(
                              child: Text(
                                festivalEventText[idx],
                                style: TextStyle(
                                  color: festivalEvent[idx]
                                      ? white : Color(0xFF888888),
                                  fontSize: 13.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (idx) => StaggeredTile.fit(1),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    whiteSpaceH(25),
                    Row(
                      children: <Widget>[
                        Image.asset("assets/map/icon_market.png", width: 36, height: 36,),
                        whiteSpaceW(15),
                        Text("전통시장", style: TextStyle(
                            fontSize: 14, color: black
                        ),),
                        whiteSpaceW(10),
                        Expanded(
                          child: allSelectButton(1),
                        ),
                        whiteSpaceW(10),
                        Expanded(
                          child: allSelectReleaseButton(1),
                        )
                      ],
                    ),
                    StaggeredGridView.countBuilder(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      itemCount: traditionalMarket.length,
                      itemBuilder: (context, idx) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              traditionalMarket[idx] = !traditionalMarket[idx];
                            });
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: traditionalMarket[idx]
                                  ? Color(0xFFFE9700)
                                  : Color(0xFFE3E3E3),
                            ),
                            child: Center(
                              child: Text(
                                traditionalMarketText[idx],
                                style: TextStyle(
                                  color: traditionalMarket[idx]
                                      ? white
                                      : Color(0xFF888888),
                                  fontSize: 13.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (idx) => StaggeredTile.fit(1),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    whiteSpaceH(25),
                    Row(
                      children: <Widget>[
                        Image.asset("assets/map/icon_thema.png", width: 36, height: 36,),
                        whiteSpaceW(15),
                        Text("테마여행", style: TextStyle(
                            fontSize: 14, color: black
                        ),),
                        whiteSpaceW(10),
                        Expanded(
                          child: allSelectButton(2),
                        ),
                        whiteSpaceW(10),
                        Expanded(
                          child: allSelectReleaseButton(2),
                        )
                      ],
                    ),
                    StaggeredGridView.countBuilder(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 15.0,
                      itemCount: themeTravel.length,
                      itemBuilder: (context, idx) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              themeTravel[idx] = !themeTravel[idx];
                            });
                          },
                          child: Container(
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: themeTravel[idx]
                                  ? Color(0xFFFE9700)
                                  : Color(0xFFE3E3E3),
                            ),
                            child: Center(
                              child: AutoSizeText(
                                themeTravelText[idx],
                                maxLines: 1,
                                minFontSize: 8,
                                style: TextStyle(
                                  color: themeTravel[idx]
                                      ? white : Color(0xFF888888),
                                  fontSize: 13.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (idx) => StaggeredTile.fit(1),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

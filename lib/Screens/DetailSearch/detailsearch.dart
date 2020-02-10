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
  List<bool> recommendedInformation;

  DetailSearch(
      {Key key,
      this.festivalEvent,
      this.traditionalMarket,
      this.themeTravel,
      this.recommendedInformation})
      : super(key: key);

  @override
  _DetailSearch createState() => _DetailSearch();
}

class _DetailSearch extends State<DetailSearch> {
  // 축제행사
  List<bool> festivalEvent = [true, false, true]; // 축제, 행사, 공연
  List<String> festivalEventText = ['축제', '행사', '공연'];

  // 전통시장
  List<bool> traditionalMarket = [false, false, false]; // 5일장, 상설시장, 야시장
  List<String> traditionalMarketText = ['5일장', '상설시장', '야시장'];

  // 추천정보
  List<bool> recommendedInformation = [
    false,
    false,
    false
  ]; // 추천행사, 할인이벤트, 지역특산물
  List<String> recommendedInformationText = ['추천행사', '할인이벤트', '지역특산물'];

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
    '종교유적'
  ];

  DetailSearch detailSearchList;

  getOptionData() {
    setState(() {
      festivalEvent = widget.festivalEvent;
      traditionalMarket = widget.traditionalMarket;
      themeTravel = widget.themeTravel;
      recommendedInformation = widget.recommendedInformation;
    });
  }

  @override
  void initState() {
//    SchedulerBinding.instance.addPostFrameCallback((_) => getOptionData());
    super.initState();

    getOptionData();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Color.fromARGB(255, 235, 235, 235),
      appBar: AppBar(
        backgroundColor: mainColor,
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            detailSearchList = DetailSearch(
              festivalEvent: festivalEvent,
              traditionalMarket: traditionalMarket,
              themeTravel: themeTravel,
              recommendedInformation: recommendedInformation,
            );
            Navigator.of(context).pop(detailSearchList);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
        ),
        title: Text(
          "상세검색",
          style: TextStyle(
              color: white, fontWeight: FontWeight.w600, fontSize: 16.7),
        ),
        centerTitle: true,
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: GestureDetector(
              onTap: () {
                detailSearchList = DetailSearch(
                  festivalEvent: festivalEvent,
                  traditionalMarket: traditionalMarket,
                  themeTravel: themeTravel,
                  recommendedInformation: recommendedInformation,
                );
                Navigator.of(context).pop(detailSearchList);
              },
              child: Container(
                width: 30,
                height: 30,
                color: mainColor,
                child: Center(
                  child: Text(
                    "완료",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.3, color: white),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      body: WillPopScope(
        onWillPop: () {
          detailSearchList = DetailSearch(
            festivalEvent: festivalEvent,
            traditionalMarket: traditionalMarket,
            themeTravel: themeTravel,
            recommendedInformation: recommendedInformation,
          );
          Navigator.of(context).pop(detailSearchList);

          return null;
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              whiteSpaceH(26),
              Text(
                "축제행사",
                style: TextStyle(
                    color: black, fontWeight: FontWeight.w600, fontSize: 13.3),
              ),
              whiteSpaceH(10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 66.7,
                color: white,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 13.3, bottom: 13.3, left: 16, right: 16),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    itemCount: festivalEvent.length,
                    itemBuilder: (context, idx) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            festivalEvent[idx] = !festivalEvent[idx];
                          });
                        },
                        child: idx == 1
                            ? Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.3),
                                    color: festivalEvent[idx]
                                        ? Color(0xFF6fc6ff)
                                        : Color(0xFF959595),
                                  ),
                                  child: Center(
                                    child: Text(
                                      festivalEventText[idx],
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 13.3,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.3),
                                  color: festivalEvent[idx]
                                      ? Color(0xFF6fc6ff)
                                      : Color(0xFF959595),
                                ),
                                child: Center(
                                  child: Text(
                                    festivalEventText[idx],
                                    style: TextStyle(
                                      color: white,
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
                ),
              ),
              whiteSpaceH(10),
              Text(
                "전통시장",
                style: TextStyle(
                    color: black, fontWeight: FontWeight.w600, fontSize: 13.3),
              ),
              whiteSpaceH(10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 66.7,
                color: white,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 13.3, bottom: 13.3, left: 16, right: 16),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    itemCount: traditionalMarket.length,
                    itemBuilder: (context, idx) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            traditionalMarket[idx] = !traditionalMarket[idx];
                          });
                        },
                        child: idx == 1
                            ? Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.3),
                                    color: traditionalMarket[idx]
                                        ? Color(0xFFff6a23)
                                        : Color(0xFF959595),
                                  ),
                                  child: Center(
                                    child: Text(
                                      traditionalMarketText[idx],
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 13.3,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.3),
                                  color: traditionalMarket[idx]
                                      ? Color(0xFFff6a23)
                                      : Color(0xFF959595),
                                ),
                                child: Center(
                                  child: Text(
                                    traditionalMarketText[idx],
                                    style: TextStyle(
                                      color: white,
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
                ),
              ),
              whiteSpaceH(10),
              Text(
                "추천정보",
                style: TextStyle(
                    color: black, fontWeight: FontWeight.w600, fontSize: 13.3),
              ),
              whiteSpaceH(10),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 66.7,
                color: white,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 13.3, bottom: 13.3, left: 16, right: 16),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    itemCount: recommendedInformation.length,
                    itemBuilder: (context, idx) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            recommendedInformation[idx] =
                                !recommendedInformation[idx];
                          });
                        },
                        child: idx == 1
                            ? Padding(
                                padding: EdgeInsets.only(left: 4, right: 4),
                                child: Container(
                                  width: MediaQuery.of(context).size.width,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.3),
                                    color: recommendedInformation[idx]
                                        ? Color(0xFF68c875)
                                        : Color(0xFF959595),
                                  ),
                                  child: Center(
                                    child: Text(
                                      recommendedInformationText[idx],
                                      style: TextStyle(
                                        color: white,
                                        fontSize: 13.3,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width,
                                height: 40,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3.3),
                                  color: recommendedInformation[idx]
                                      ? Color(0xFF68c875)
                                      : Color(0xFF959595),
                                ),
                                child: Center(
                                  child: Text(
                                    recommendedInformationText[idx],
                                    style: TextStyle(
                                      color: white,
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
                ),
              ),
              whiteSpaceH(10),
              Text(
                "테마여행",
                style: TextStyle(
                    color: black, fontWeight: FontWeight.w600, fontSize: 13.3),
              ),
              whiteSpaceH(10),
              Container(
                width: MediaQuery.of(context).size.width,
//                height: 113.3,
                color: white,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: 13.3, bottom: 3.3, left: 16, right: 16),
                  child: StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 10.0,
                    itemCount: themeTravel.length,
                    itemBuilder: (context, idx) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            themeTravel[idx] = !themeTravel[idx];
                          });
                        },
                        child: (idx == 1 || idx == 4 || idx == 7 || idx == 10 || idx == 13 || idx == 16 || idx == 19)
                            ? Padding(
                          padding: EdgeInsets.only(left: 4, right: 4),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3.3),
                              color: themeTravel[idx]
                                  ? Color(0xFFbc65ff)
                                  : Color(0xFF959595),
                            ),
                            child: Center(
                              child: Text(
                                themeTravelText[idx],
                                style: TextStyle(
                                  color: white,
                                  fontSize: 13.3,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                            : Container(
                          width: MediaQuery.of(context).size.width,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3.3),
                            color: themeTravel[idx]
                                ? Color(0xFFbc65ff)
                                : Color(0xFF959595),
                          ),
                          child: Center(
                            child: Text(
                              themeTravelText[idx],
                              style: TextStyle(
                                color: white,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

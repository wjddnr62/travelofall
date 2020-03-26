import 'package:flutter/material.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class DiscountEvent extends StatefulWidget {
  VoidCallback back;

  DiscountEvent({Key key, this.back}) : super(key: key);

  @override
  _DiscountEvent createState() => _DiscountEvent();
}

class _DiscountEvent extends State<DiscountEvent> {

  bool selectEvent = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        widget.back();
        return null;
      },
      child: Scaffold(
        backgroundColor: white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            whiteSpaceH(20),
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "진행중인 이벤트",
                style: TextStyle(
                    color: black, fontWeight: FontWeight.w600, fontSize: 14),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectEvent = false;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            color: white,
                            child: Center(
                              child: Text(
                                "진행중인 이벤트",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: !selectEvent ? mainColor : black),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: !selectEvent ? mainColor : white,
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectEvent = true;
                        });
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            color: white,
                            child: Center(
                              child: Text(
                                "완료된 이벤트",
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: selectEvent ? mainColor : black),
                              ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 1,
                            color: selectEvent ? mainColor : white,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 1,
              color: Color(0xFFDDDDDD),
            ),
            Expanded(
              child: Container(
                color: white,
                child: Center(
                  child: Text(!selectEvent ? "진행중인 이벤트가 없습니다." : "완료된 이벤트가 없습니다.", style: TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 16, color: black
                  ),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

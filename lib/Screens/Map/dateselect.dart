import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class DateSelect extends StatefulWidget {
  @override
  _DateSelect createState() => _DateSelect();
}

class _DateSelect extends State<DateSelect> {

  TextEditingController viewDate = TextEditingController();
  String selectDate = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        if (selectDate != "") {
          print("DateTime.now : ${DateTime.now()}, ${DateTime.now().day}");
          int calDate = DateTime.parse(selectDate).difference(DateTime.now()).inDays;
          if (calDate >= 0) {
            calDate += 1;
          }
          print("calDate : " + calDate.toString());
          Navigator.of(context).pop(calDate);
        } else {
          Navigator.of(context).pop("");
        }
        return null;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: white,
          body: Stack(
            children: <Widget>[
              Positioned(
                top: 20,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.close,
                    size: 24,
                    color: black,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: GestureDetector(
                  onTap: () {
                    if (selectDate != "") {
                      print("DateTime.now : ${DateTime.now()}, ${DateTime.now().day}");
                      int calDate = DateTime.parse(selectDate).difference(DateTime.now()).inDays;
                      print("calDate : " + calDate.toString());
                      if (calDate >= 0) {
                        calDate += 1;
                        print("day : " + DateTime.parse(selectDate).day.toString() + ", " + DateTime.now().day.toString());
//                        if (DateTime.parse(selectDate).day != DateTime.now().day) {
//                          if (calDate == 0) {
//                            calDate += 1;
//                          }
//                        }
                      }
                      print("calDate2 : " + calDate.toString());
                      Navigator.of(context).pop(calDate);
                    } else {
                      Navigator.of(context).pop("");
                    }
                  },
                  child: Container(
                    width: 30,
                    height: 20,
                    child: Center(
                      child: Text(
                        "완료",
                        style: TextStyle(fontSize: 14, color: Color(0xFF02A7F2)),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("날짜 선택", style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600, color: black
                      ),),
                      whiteSpaceH(5),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 45,
                        decoration: BoxDecoration(
                            color: white,
                            border: Border.all(color: Color(0xFFDDDDDD))),
                        child: TextFormField(
                          controller: viewDate,
                          onTap: () {
                            DatePicker.showDatePicker(context,
                                minTime: DateTime(1930, 1, 1),
                                showTitleActions: true, onChanged: (date) {
                                  setState(() {
                                    if (date.month.toString().length < 2) {
                                      selectDate = "${date.year}-0${date.month}-${date.day}";
                                      viewDate.text =
                                      "${date.year}년 0${date.month}월 ${date.day}일";
                                      print("selectDate : ${selectDate}");
                                    } else {
                                      selectDate = "${date.year}-${date.month}-${date.day}";
                                      viewDate.text =
                                      "${date.year}년 ${date.month}월 ${date.day}일";
                                      print("selectDate : ${selectDate}");
                                    }
                                  });
                                }, onConfirm: (date) {
                                  setState(() {
                                    if (date.month.toString().length < 2) {
                                      selectDate = "${date.year}-0${date.month}-${date.day}";
                                      viewDate.text =
                                      "${date.year}년 0${date.month}월 ${date.day}일";
                                      print("selectDate : ${selectDate}");
                                    } else {
                                      selectDate = "${date.year}-${date.month}-${date.day}";
                                      viewDate.text =
                                      "${date.year}년 ${date.month}월 ${date.day}일";
                                      print("selectDate : ${selectDate}");
                                    }
                                  });
                                }, locale: LocaleType.ko);
                          },
                          readOnly: true,
                          style: TextStyle(fontSize: 14, color: black),
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 10, right: 10, bottom: 5)),
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
}

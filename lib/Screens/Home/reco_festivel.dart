import 'package:flutter/material.dart';
import 'package:travelofall/public/color.dart';

class RecoFestival extends StatefulWidget {

  VoidCallback back;

  RecoFestival({Key key, this.back}) : super(key : key);

  @override
  _RecoFestival createState() => _RecoFestival();
}

class _RecoFestival extends State<RecoFestival> {

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
        body: Container(
          child: Center(
            child: Text(
              "추천행사 정보가 없습니다.", style: TextStyle(
              fontWeight: FontWeight.w600, fontSize: 16, color: black
            ),
            ),
          ),
        ),
      ),
    );
  }

}
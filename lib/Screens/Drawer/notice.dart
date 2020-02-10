import 'package:flutter/material.dart';
import 'package:travelofall/public/color.dart';

class Notice extends StatefulWidget {
  @override
  _Notice createState() => _Notice();
}

class _Notice extends State<Notice> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFebebeb),
      appBar: AppBar(
        backgroundColor: mainColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios, color: white,),
        ),
        title: Text("공지사항", textAlign: TextAlign.center, style: TextStyle(
          fontSize: 16.7,
          color: white, fontWeight: FontWeight.w600
        ),),
      ),
    );
  }

}
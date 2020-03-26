import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:travelofall/Util/whiteSpace.dart';
import 'package:travelofall/public/color.dart';

class Review extends StatefulWidget {
  String title;
  int shNo;

  Review({Key key, this.title, this.shNo}) : super(key: key);

  @override
  _Review createState() => _Review();
}

class _Review extends State<Review> {
  double rating = 0.0;
  TextEditingController reviewController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
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
          "리뷰작성",
          style: TextStyle(
              fontSize: 14, color: white, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            whiteSpaceH(20),
            Text(widget.title, style: TextStyle(
              fontWeight: FontWeight.bold, color: black, fontSize: 20
            ),),
            whiteSpaceH(20),
            Text(
              rating.toString(),
              style: TextStyle(color: mainColor, fontSize: 20),
            ),
            whiteSpaceH(10),
            RatingBar(
              glow: false,
              ignoreGestures: false,
              initialRating: 0.0,
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 1),
              ratingWidget: RatingWidget(
                  full: Image.asset(
                    "assets/detail/star_full.png",
                    width: 20,
                    height: 20,
                  ),
                  half: null,
                  empty: Image.asset(
                    "assets/detail/star_empty.png",
                    width: 20,
                    height: 20,
                  )),
              tapOnlyMode: false,
              itemSize: 40,
              maxRating: 5,
              onRatingUpdate: (rating) {
                print(rating);
                setState(() {
                  this.rating = rating;
                });
              },
            ),
            whiteSpaceH(15),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                controller: reviewController,
                style: TextStyle(fontSize: 14, color: Color(0xFF333333)),
                textInputAction: TextInputAction.done,
                cursorColor: mainColor,
                decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: mainColor)),
                    hintText: "리뷰 입력",
                    hintStyle: TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 167, 167, 167)),
                    contentPadding:
                        EdgeInsets.only(bottom: 0, right: 10, left: 10)),
              ),
            ),
            whiteSpaceH(20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                child: RaisedButton(
                  elevation: 0.0,
                  color: mainColor,
                  onPressed: () {},
                  child: Container(
                    child: Center(
                      child: Text(
                        "작성완료",
                        style: TextStyle(
                            fontSize: 14,
                            color: white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

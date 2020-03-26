class ReviewData {
  double distance;
  ReviewReturn reviewReturn;
  int like;
  int noLike;
  int allCount;
  int selectPage;

  ReviewData({this.distance, this.reviewReturn, this.like, this.noLike, this.allCount, this.selectPage});

  factory ReviewData.fromJson(Map<dynamic, dynamic> data) {
    if (data['result'] == 1) {
      return ReviewData(
        distance: data['distance'],
        reviewReturn: ReviewReturn(
          idx: data['reviewReturn']['idx'],
          rvContent: data['reviewReturn']['rv_content'],
          rvRating: data['reviewReturn']['rv_rating'],
          rvDate: data['reviewReturn']['rv_date'],
          name: data['reviewReturn']['name'],
          shNo: data['reviewReturn']['sh_no']
        ),
        like: data['like'],
        noLike: data['noLike'],
        allCount: data['allCount'],
        selectPage: data['selectPage']
      );
    }
    return null;
  }
}

class ReviewReturn {
  int idx;
  String rvContent;
  double rvRating;
  String rvDate;
  String name;
  int shNo;

  ReviewReturn({this.idx, this.rvContent, this.rvRating, this.rvDate, this.name, this.shNo});
}


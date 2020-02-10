class InfoMation {
  int no;
  String local;
  String local_detail;
  String code;
  String startDate;
  String endDate;
  String lat;
  String lon;
  int type_big;
  int type_small;
  String host;
  String title;
  String tel;
  String site;
  String search;
  String explan;
  String explan2;
  String etc;
  String good;
  String noticeDate;
  String special;

  InfoMation({this.no, this.local, this.local_detail, this.code, this.startDate, this.endDate, this.lat, this.lon, this. type_big, this.type_small, this.host, this.title, this.tel, this.site, this. search, this.explan, this.explan2, this.etc, this.good, this.noticeDate, this.special});

  factory InfoMation.fromJson(Map<dynamic, dynamic> data) {
    if (data['result'] == 1) {
      if (data.length != 0) {
        return InfoMation(
          no: data['sh_no'],
          local: data['sh_local'],
          local_detail: data['sh_local_detail'],
          code: data['sh_code'],
          startDate: data['sh_startDate'],
          endDate: data['sh_endDate'],
          lat: data['sh_lat'],
          lon: data['sh_lon'],
          type_big: data['sh_type_big'],
          type_small: data['sh_type_small'],
          host: data['sh_host'],
          title: data['sh_title'],
          tel: data['sh_tel'],
          site: data['sh_site'],
          search: data['sh_search'],
          explan: data['sh_explan'],
          explan2: data['sh_explan2'],
          etc: data['sh_etc'],
          good: data['sh_good'],
          noticeDate: data['sh_noticeDate'],
          special: data['sh_special']
        );
      }
    }
    return null;
  }
}
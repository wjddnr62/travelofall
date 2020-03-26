class UserData {
  int idx;
  int type;
  String email;
  String name;
  String birthday;
  String phone;
  String company;
  String company_number;
  String rep_phone;
  String site;
  String address;

  UserData({this.idx, this.type, this.email, this.name, this.birthday, this.phone, this.company, this.company_number, this.rep_phone, this.site, this.address});

  factory UserData.fromJson(Map<dynamic, dynamic> data) {
    if (data['result'] == 1) {
      if (data.length != 0) {
        return UserData(
          idx: data['idx'],
          type: data['type'],
          email: data['email'],
          name: data['name'],
          birthday: data['birthday'],
          phone: data['phone'],
          company: data['company'],
          company_number: data['company_number'],
          rep_phone: data['rep_phone'],
          site: data['site'],
          address: data['address']
        );
      }
    }
    return null;
  }
}
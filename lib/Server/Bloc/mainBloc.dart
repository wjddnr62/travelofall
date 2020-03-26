import 'package:rxdart/rxdart.dart';
import 'package:travelofall/Server/Repository/mainRepository.dart';
import 'package:travelofall/Server/Model/user.dart';

class MainBloc {
  final _mainRepository = MainRepository();

  String _searchText = "";


  String get searchText => _searchText;

  set searchText(String value) {
    _searchText = value;
  }

  String _locale = "ko";

  String get locale => _locale;

  set locale(String value) {
    _locale = value;
  }

  UserData _userData;

  UserData get userData => _userData;

  set userData(value) {
    _userData = value;
  }

  String _selectLocal;
  double _selectLat;
  double _selectLon;
  int _selectType;

  String get selectLocal => _selectLocal;

  set selectLocal(String value) {
    _selectLocal = value;
  }

  double get selectLon => _selectLon;

  set selectLon(double value) {
    _selectLon = value;
  }

  int get selectType => _selectType;

  set selectType(int value) {
    _selectType = value;
  }

  double get selectLat => _selectLat;

  set selectLat(double value) {
    _selectLat = value;
  }

  final _local = BehaviorSubject<String>();
  final _typeBig = BehaviorSubject<String>();
  final _typeSmall = BehaviorSubject<String>();
  final _date = BehaviorSubject<int>();

  final _search = BehaviorSubject<String>();

  Observable<String> get search => _search.stream;

  Function(String) get setSearch => _search.sink.add;

  Observable<String> get local => _local.stream;

  Observable<String> get typeBig => _typeBig.stream;

  Observable<String> get typeSmall => _typeSmall.stream;

  Observable<int> get date => _date.stream;

  Function(String) get setLocal => _local.sink.add;

  Function(String) get setTypeBig => _typeBig.sink.add;

  Function(String) get setTypeSmall => _typeSmall.sink.add;

  Function(int) get setDate => _date.sink.add;

  Future<String> getInfo() =>
      _mainRepository.getInfo(_local.value, _date.value);

  Future<String> getSearchInfo() =>
      _mainRepository.getSearchInfo(_local.value, _date.value, _search.value);

  Future<String> getInfoAll() => _mainRepository.getInfoAll(_date.value);

  Future<String> getSearchInfoAll() => _mainRepository.getSearchInfoAll(_date.value, _search.value);



  final _type = BehaviorSubject<int>();
  final _email = BehaviorSubject<String>();
  final _pass = BehaviorSubject<String>();
  final _name = BehaviorSubject<String>();
  final _birthday = BehaviorSubject<String>();
  final _phone = BehaviorSubject<String>();
  final _company = BehaviorSubject<String>();
  final _company_number = BehaviorSubject<String>();
  final _rep_phone = BehaviorSubject<String>();
  final _site = BehaviorSubject<String>();
  final _address = BehaviorSubject<String>();

  Observable<int> get type => _type.stream;

  Observable<String> get email => _email.stream;

  Observable<String> get pass => _pass.stream;

  Observable<String> get name => _name.stream;

  Observable<String> get birthday => _birthday.stream;

  Observable<String> get phone => _phone.stream;

  Observable<String> get company => _company.stream;

  Observable<String> get company_number => _company_number.stream;

  Observable<String> get rep_phone => _rep_phone.stream;

  Observable<String> get site => _site.stream;

  Observable<String> get address => _address.stream;

  Function(int) get setType => _type.sink.add;

  Function(String) get setEmail => _email.sink.add;

  Function(String) get setPass => _pass.sink.add;

  Function(String) get setName => _name.sink.add;

  Function(String) get setBirthday => _birthday.sink.add;

  Function(String) get setPhone => _phone.sink.add;

  Function(String) get setCompany => _company.sink.add;

  Function(String) get setCompany_number => _company_number.sink.add;

  Function(String) get setRep_phone => _rep_phone.sink.add;

  Function(String) get setSite => _site.sink.add;

  Function(String) get setAddress => _address.sink.add;

  Future<String> insertUser() => _mainRepository.insertUser(
      _type.value,
      _email.value,
      _pass.value,
      _name.value,
      _birthday.value,
      _phone.value,
      _company.value,
      _company_number.value,
      _rep_phone.value,
      _site.value,
      _address.value);

  Future<String> checkEmail() => _mainRepository.checkEmail(_email.value);

  Future<String> loginUser() => _mainRepository.loginUser(_email.value, _pass.value);


  final _no = BehaviorSubject<int>();
  final _idx = BehaviorSubject<int>();
  final _rating = BehaviorSubject<double>();
  final _content = BehaviorSubject<String>();
  final _offset = BehaviorSubject<int>();

  Observable<int> get no => _no.stream;
  Observable<int> get idx => _idx.stream;
  Observable<double> get rating => _rating.stream;
  Observable<String> get content => _content.stream;
  Observable<int> get offset => _offset.stream;

  Function(int) get setNo => _no.sink.add;
  Function(int) get setIdx => _idx.sink.add;
  Function(double) get setRating => _rating.sink.add;
  Function(String) get setContent => _content.sink.add;
  Function(int) get setOffset => _offset.sink.add;

  Future<String> reviewInsert() => _mainRepository.reviewInsert(_no.value, _idx.value, _rating.value, _content.value);

  Future<String> reviewSelect() => _mainRepository.reviewSelect(_no.value, _offset.value);

  dispose() {
    _local.close();
    _typeBig.close();
    _typeSmall.close();
    _date.close();
  }
}

final mainBloc = MainBloc();

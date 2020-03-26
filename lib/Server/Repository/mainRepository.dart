import 'package:travelofall/Server/Provider/mainProvider.dart';

class MainRepository {
  final _mainProvider = MainProvider();

  Future<String> getInfo(local, date) => _mainProvider.getInfo(local, date);

  Future<String> getSearchInfo(local, date, search) => _mainProvider.getSearchInfo(local, search, date);

  Future<String> getInfoAll(date) => _mainProvider.getInfoAll(date);

  Future<String> getSearchInfoAll(date, search) => _mainProvider.getSearchInfoAll(date, search);

  Future<String> insertUser(type, email, pass, name, birthday, phone, company,
          company_number, rep_phone, site, address) =>
      _mainProvider.insertUser(type, email, pass, name, birthday, phone,
          company, company_number, rep_phone, site, address);

  Future<String> checkEmail(email) => _mainProvider.checkEmail(email);

  Future<String> loginUser(email, pass) => _mainProvider.loginUser(email, pass);

  Future<String> reviewInsert(no, idx, rating, content) => _mainProvider.reviewInsert(no, idx, rating, content);

  Future<String> reviewSelect(no, offset) => _mainProvider.reviewSelect(no, offset);

}

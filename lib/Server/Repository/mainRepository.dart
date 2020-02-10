
import 'package:travelofall/Server/Provider/mainProvider.dart';

class MainRepository {
  final _mainProvider = MainProvider();

  Future<String> getInfo(local) => _mainProvider.getInfo(local);

  Future<String> getInfoAll() => _mainProvider.getInfoAll();
}
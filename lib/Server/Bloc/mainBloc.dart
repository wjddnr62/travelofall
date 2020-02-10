import 'package:rxdart/rxdart.dart';
import 'package:travelofall/Server/Repository/mainRepository.dart';


class MainBloc {
  final _mainRepository = MainRepository();

  final _local = BehaviorSubject<String>();
  final _typeBig = BehaviorSubject<String>();
  final _typeSmall = BehaviorSubject<String>();

  Observable<String> get local => _local.stream;
  Observable<String> get typeBig => _typeBig.stream;
  Observable<String> get typeSmall => _typeSmall.stream;

  Function(String) get setLocal => _local.sink.add;
  Function(String) get setTypeBig => _typeBig.sink.add;
  Function(String) get setTypeSmall => _typeSmall.sink.add;

  Future<String> getInfo() => _mainRepository.getInfo(_local.value);

  Future<String> getInfoAll() => _mainRepository.getInfoAll();

  dispose() {
    _local.close();
    _typeBig.close();
    _typeSmall.close();
  }
}


final mainBloc = MainBloc();
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

class DioAdapterMock extends Mock implements HttpClientAdapter {
  static final DioAdapterMock _dioAdapterMock = DioAdapterMock._internal();
  DioAdapterMock._internal();

  factory DioAdapterMock() {
    return _dioAdapterMock;
  }
}

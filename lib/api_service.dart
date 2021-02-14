import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_mock_network_calls/dio_adapter_mock.dart';

class ApiService {
  static Dio getDioClient() {
    Dio dio = Dio();

    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      print('RUNNING IN TEST ENV');
      dio.httpClientAdapter = DioAdapterMock();
    }

    dio.options.baseUrl = 'http://demo7683289.mockable.io/';
    dio.options.connectTimeout = 20000;
    dio.options.receiveTimeout = 20000;

    return dio;
  }

  static Future<dynamic> callAPI1() async {
    Dio dioClient = getDioClient();
    return dioClient
        .get(
      'data1',
    )
        .then(
      (dynamic response) {
        return response;
      },
    );
  }

  static Future<dynamic> callAPI2() async {
    Dio dioClient = getDioClient();
    return dioClient
        .get(
      'data2',
    )
        .then(
      (dynamic response) {
        return response;
      },
    );
  }
}

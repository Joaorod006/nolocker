import 'package:dio/dio.dart';

// dio.interceptors.add(LogInterceptor(
//   requestBody: true,
//   responseBody: true,
// ));

final BaseOptions options = BaseOptions(
  baseUrl: 'http://172.16.0.227:8000',
  connectTimeout: Duration(seconds: 10),
  receiveTimeout: Duration(seconds: 10),
  headers: {
    'Content-Type': 'application/json',
  },
);

final Dio dio = Dio(
  options,
);

class DioClient {
  static final Dio _instance = dio;

  static Dio get instance => _instance;
}

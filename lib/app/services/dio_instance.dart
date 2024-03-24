import 'package:dio/dio.dart';

// dio.interceptors.add(LogInterceptor(
//   requestBody: true,
//   responseBody: true,
// ));

final BaseOptions options = BaseOptions(
  baseUrl: 'https://your-api-base-url.com',
  connectTimeout: Duration(seconds: 5),
  receiveTimeout: Duration(seconds: 3),
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

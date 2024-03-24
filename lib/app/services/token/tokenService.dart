import 'package:dio/dio.dart';
import 'package:nolocker/app/services/dio_instance.dart';

class TokenService {
  Future<Response<dynamic>?> getNFTs() async {
    try {
      final response = await DioClient.instance.get(
        '/contrato/exibir/',
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      print("--------{ response }-----------------------------------");
      print(response.data);
      return response;
    } on DioException catch (e) {
      print(e.error);
      return null;
    }
  }
}

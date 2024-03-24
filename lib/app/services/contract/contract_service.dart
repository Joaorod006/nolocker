import 'package:dio/dio.dart';
import 'package:nolocker/app/services/dio_instance.dart';

class ContractService {
  Future<Response<dynamic>?> createContract(String jsonData) async {
    print("--------{ jsonData }-----------------------------------");
    print(jsonData);
    try {
      final response = await DioClient.instance.post(
        '/contrato/elaborar/',
        data: jsonData,
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

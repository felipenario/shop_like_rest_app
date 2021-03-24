import 'package:dio/dio.dart';
import 'package:shop_like_app_rest/models/user.dart';
import 'package:shop_like_app_rest/utils/constants.dart';

class AdvertApi {
  Dio _dio;

  AdvertApi() {
    _dio = Dio();
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = {'Content-Type': 'application/json; charset=UTF-8'};
  }

  Future<void> signup(User user) async {
    try {
      var response = await _dio.post('usuario/', data: user.toJson());
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }
}

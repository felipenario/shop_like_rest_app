import 'package:dio/dio.dart';
import 'package:shop_like_app_rest/models/advert.dart';
import 'package:shop_like_app_rest/models/user.dart';
import 'package:shop_like_app_rest/repository/local_storage_hive.dart';
import 'package:shop_like_app_rest/utils/constants.dart';

class AdvertApi {
  static final Dio _dio = Dio(BaseOptions(
    baseUrl: BASE_URL,
    headers: {'Content-Type': 'application/json; charset=UTF-8'}
  ));

  static final AdvertApi _advertApi = AdvertApi._internal();

  static final LocalStorageHive _localStorageHive = LocalStorageHive();

  factory AdvertApi(){
    return _advertApi;
  }

  AdvertApi._internal();

 static Future<void> signup(User user) async {
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
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<String> login(User user) async {
    try {
      var response = await _dio.post('login', data: user.loginToJson());
      var token = response.data['token'];
      return token;
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<List<Advert>> getAdverts() async {
    try {
      var token = await _localStorageHive.getToken();
      var response = await _dio.get('anuncios/', options: Options(headers: {'authorization': 'Bearer ${token}'}));
      List<Advert> adverts = [];
      for(var advert in response.data) {
        adverts.add(Advert.fromJson(advert));
      }
      return adverts;
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<void> createAdvert(Advert advert) async {
    try {
      var token = await _localStorageHive.getToken();
      var response = await _dio.post('anuncios/', data: advert.toJson(), options: Options(headers: {'authorization': 'Bearer ${token}'}));
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<void> editAdvert(Advert advert) async {
   try {
      var token = await _localStorageHive.getToken();
      var response = await _dio.put('anuncios/', data: advert.toJson(), options: Options(headers: {'authorization': 'Bearer ${token}'}));
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<void> deleteAdvert(int advertId) async {
   try {
      var token = await _localStorageHive.getToken();
      var response = await _dio.delete('anuncios/${advertId}', options: Options(headers: {'authorization': 'Bearer ${token}'}));
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<User> getLoggedUser() async {
    try {
      var token = await _localStorageHive.getToken();
      var response = await _dio.get('usuario/', options: Options(headers: {'authorization': 'Bearer ${token}'}));
      return User.fromJson(response.data);
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<void> logout() async {
    try {
      var token = await _localStorageHive.getToken();
      var response = await _dio.post('logout/', options: Options(headers: {'authorization': 'Bearer ${token}'}));
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<void> editUser(User user) async {
    try {
      var token = await _localStorageHive.getToken();
      var response = await _dio.put('usuario/', data: user.toJson(), options: Options(headers: {'authorization': 'Bearer ${token}'}));
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

  static Future<void> deleteUser(User user) async {
    print(user.id);
    try {
      var token = await _localStorageHive.getToken();
      var response = await _dio.delete('usuario/', queryParameters: {'id': user.id}, options: Options(headers: {'authorization': 'Bearer ${token}'}));
    } on DioError catch (e) {
      if (DioErrorType.RECEIVE_TIMEOUT == e.type ||
          DioErrorType.CONNECT_TIMEOUT == e.type) {
        throw ('Não foi possível estabelecer conexão com o backend');
      } else if (DioErrorType.RESPONSE == e.type) {
        if (e.response.statusCode == 500) {
          throw ('Erro ao executar a operação');
        }
        if(e.response.statusCode == 404){
          throw ('URL requisitada não encontrada');
        }
      } else if (DioErrorType.DEFAULT == e.type) {
        throw (e.error.toString());
      }
    }
  }

}

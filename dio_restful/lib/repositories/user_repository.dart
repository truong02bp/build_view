import 'package:dio_restful/models/user.dart';
import 'package:dio/dio.dart';
import 'package:dio_restful/repositories/dio_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  static final UserRepository _userRepository = UserRepository._();

  UserRepository._();

  static UserRepository getInstance() {
    return _userRepository;
  }

  Future<String?> login() async {
    Dio dio = DioClient.getInstanceDio();
    String? token = await dio
        .post("http://192.168.70.61:8080/api/v1/authenticate", data: {
      'email': 'truong02.bp@gmail.com',
      'password': '123456'
    }).then((value) {
      if (value.statusCode == 200) {
        return value.data;
      }
      return null;
    });
    if (token != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", token);
    }
    return token;
  }

  Future<User?> getUserLogin() async {
    Dio dio = DioClient.getInstanceDio();
    User? user = await dio
        .get("http://192.168.70.61:8080/api/v1/user")
        .then((value) {
      if (value.statusCode == 200) {
        return User.fromJson(value.data);
      }
      return null;
    });
    return user;
  }
}

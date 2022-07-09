import 'package:dio/dio.dart';
import 'package:exam_ui/constants.dart';
import 'package:exam_ui/models/user.dart';

class UserRepository {
  static final UserRepository _userRepository = UserRepository._();

  UserRepository._();

  static UserRepository getInstance() {
    return _userRepository;
  }

  Future<List<User>?> getUsers() async {
    Dio dio = Dio();
    List<User>? users = await dio
        .get("$apiHost/user")
        .then((value) {
      if (value.statusCode == 200) {
        return value.data.map<User>((json) => User.fromJson(json)).toList();
      }
      return [];
    });
    return users;
  }
}

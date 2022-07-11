import 'package:exam_ui/models/media.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  int id;
  String email;
  String name;
  String username;
  String phone;
  String? address;
  Media avatar;


  User(
      {required this.id,
      required this.email,
      required this.name,
      required this.username,
      required this.phone,
      this.address,
      required this.avatar});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

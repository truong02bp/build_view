import 'package:exam_ui/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  int id;
  String content;
  List<Comment>? replies;
  User user;
  DateTime createdDate;
  List<User>? interactBy;

  Comment(
      {required this.id,
      required this.content,
      this.replies,
      required this.user,
      required this.createdDate,
      this.interactBy});

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);

  Map<String, dynamic> toJson() => _$CommentToJson(this);
}


import 'package:exam_ui/models/comment.dart';
import 'package:exam_ui/models/media.dart';
import 'package:exam_ui/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';
@JsonSerializable()
class Post {
  int id;
  String caption;
  Media? media;
  DateTime createdDate;
  List<User>? interactBy;
  List<User>? tags;
  List<Comment>? comments;
  User user;
  int totalComment;

  Post({required this.id, required this.user, required this.caption, required this.totalComment, this.media, this.interactBy, this.tags,  this.comments, required this.createdDate});

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
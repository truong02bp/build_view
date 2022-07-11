import 'package:json_annotation/json_annotation.dart';

part 'post_dto.g.dart';
@JsonSerializable()
class PostDto {
  int? postId;
  String? name;
  String? bytes;
  int? userId;
  String? caption;
  int? mediaId;

  PostDto({this.postId, this.name, this.bytes, this.userId, this.caption, this.mediaId});

  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);
}
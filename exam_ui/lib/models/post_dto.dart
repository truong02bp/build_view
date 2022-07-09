import 'package:json_annotation/json_annotation.dart';

part 'post_dto.g.dart';
@JsonSerializable()
class PostDto {
  String? name;
  String? bytes;
  int userId;
  String caption;

  PostDto({this.name, this.bytes, required this.userId, required this.caption});

  factory PostDto.fromJson(Map<String, dynamic> json) => _$PostDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PostDtoToJson(this);
}
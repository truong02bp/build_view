// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) {
  return Post(
    id: json['id'] as int,
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    caption: json['caption'] as String,
    totalComment: json['totalComment'] as int,
    media: json['media'] == null
        ? null
        : Media.fromJson(json['media'] as Map<String, dynamic>),
    interactBy: (json['interactBy'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    tags: (json['tags'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
    comments: (json['comments'] as List<dynamic>?)
        ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList(),
    createdDate: DateTime.parse(json['createdDate'] as String),
  );
}

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'id': instance.id,
      'caption': instance.caption,
      'media': instance.media,
      'createdDate': instance.createdDate.toIso8601String(),
      'interactBy': instance.interactBy,
      'tags': instance.tags,
      'comments': instance.comments,
      'user': instance.user,
      'totalComment': instance.totalComment,
    };

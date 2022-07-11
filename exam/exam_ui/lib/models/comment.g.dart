// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) {
  return Comment(
    id: json['id'] as int,
    content: json['content'] as String,
    replies: (json['replies'] as List<dynamic>?)
        ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
        .toList(),
    user: User.fromJson(json['user'] as Map<String, dynamic>),
    createdDate: DateTime.parse(json['createdDate'] as String),
    interactBy: (json['interactBy'] as List<dynamic>?)
        ?.map((e) => User.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'replies': instance.replies,
      'user': instance.user,
      'createdDate': instance.createdDate.toIso8601String(),
      'interactBy': instance.interactBy,
    };

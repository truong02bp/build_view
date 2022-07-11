// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostDto _$PostDtoFromJson(Map<String, dynamic> json) {
  return PostDto(
    postId: json['postId'] as int?,
    name: json['name'] as String?,
    bytes: json['bytes'] as String?,
    userId: json['userId'] as int?,
    caption: json['caption'] as String?,
    mediaId: json['mediaId'] as int?,
  );
}

Map<String, dynamic> _$PostDtoToJson(PostDto instance) => <String, dynamic>{
      'postId': instance.postId,
      'name': instance.name,
      'bytes': instance.bytes,
      'userId': instance.userId,
      'caption': instance.caption,
      'mediaId': instance.mediaId,
    };

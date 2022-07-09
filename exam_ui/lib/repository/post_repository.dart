import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:exam_ui/constants.dart';

import 'package:exam_ui/models/post.dart';
import 'package:exam_ui/models/post_dto.dart';

class PostRepository {
  static PostRepository _postRepository = PostRepository._();

  PostRepository._();

  static PostRepository getInstance() {
    return _postRepository;
  }

  Future<Post?> uploadPost({required PostDto postDto}) async {
    Dio dio = Dio();
    Post? post = await dio
        .post("$apiHost/post", data: jsonEncode(postDto))
        .then((value) {
      if (value.statusCode == 200) {
        return Post.fromJson(value.data);
      }
    });
    return post;
  }

  Future<List<Post>?> getPostByUserId(
      {required int userId, required int page, required int limit}) async {
    Dio dio = Dio();
    List<Post>? posts = await dio.get("$apiHost/post", queryParameters: {
      "userId": "$userId",
      "page": "$page",
      "limit": "$limit"
    }).then((value) {
      if (value.statusCode == 200) {
        return value.data.map<Post>((json) => Post.fromJson(json)).toList();
      }
      return null;
    });
    return posts;
  }

  Future<String?> deleteById(
      {required int id}) async {
    Dio dio = Dio();
    String? message = await dio.delete("$apiHost/post", queryParameters: {
      "id": "$id",
    }).then((value) {
      if (value.statusCode == 200) {
        return value.data;
      }
      return null;
    });
    return message;
  }
}

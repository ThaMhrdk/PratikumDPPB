import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../../core/dio_client.dart';
import 'post_model.dart';

class PostRepository {
  PostRepository(this._client);
  final DioClient _client;

  Future<List<PostModel>> fetchPosts() async {
    final response = await _client.get<List<dynamic>>('/posts');
    final data = response.data ?? [];
    return data
        .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<PostModel> getPost(int id) async {
    final response = await _client.get<Map<String, dynamic>>('/posts/$id');
    return PostModel.fromJson(response.data ?? {});
  }

  Future<PostModel> createPost({
    required String title,
    required String author,
    required String article,
    File? imageFile,
  }) async {
    FormData formData = FormData.fromMap({
      'title': title,
      'author': author,
      'article': article,
      if (imageFile != null)
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ),
    });

    final response = await _client.post<Map<String, dynamic>>(
      '/posts',
      data: formData,
    );

    return PostModel.fromJson(response.data ?? {});
  }

  Future<PostModel> updatePost({
    required int id,
    String? title,
    String? author,
    String? article,
    File? imageFile,
  }) async {
    FormData formData = FormData.fromMap({
      if (title != null) 'title': title,
      if (author != null) 'author': author,
      if (article != null) 'article': article,
      if (imageFile != null)
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ),
    });

    final response = await _client.post<Map<String, dynamic>>(
      '/posts/$id',
      data: formData,
    );

    return PostModel.fromJson(response.data ?? {});
  }

  Future<String> deletePost(int id) async {
    final response = await _client.delete<Map<String, dynamic>>('/posts/$id');
    final data = response.data ?? {};
    return data['message'] as String? ?? 'Post deleted successfully';
  }
}

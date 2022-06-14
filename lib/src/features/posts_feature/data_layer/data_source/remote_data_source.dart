import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:tdd_app/src/core/constants/api_constants.dart';
import 'package:tdd_app/src/core/errors/exceptions.dart';
import '../models/post_model.dart';
import 'package:http/http.dart' as http;

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();

  Future<Unit> delete(int postId);

  Future<Unit> updatePost(PostModel post);

  Future<Unit> createPost(PostModel post);
}

class PostRemoteDataSourceImplWithHttp implements PostRemoteDataSource {
  final http.Client client;

  PostRemoteDataSourceImplWithHttp({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final http.Response response = await http.get(
      Uri.parse(baseUrl + 'posts'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body) as List;
      List<PostModel> posts = jsonData
          .map<PostModel>((element) => PostModel.fromJson(element))
          .toList();
      return Future.value(posts);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> createPost(PostModel post) async {
    final Map<String, dynamic> jsonBody = {
      'title': post.title,
      'body': post.body,
    };
    final http.Response response = await http.post(
      Uri.parse(baseUrl + '/posts'),
      body: jsonBody,
    );
    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> delete(int postId) async {
    final http.Response response =
        await http.delete(Uri.parse(baseUrl + '/posts/$postId'));
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final String postId = post.id.toString();
    final Map<String, dynamic> jsonBody = {
      'title': post.title,
      'body': post.body,
    };
    final http.Response response = await http.put(
      Uri.parse(baseUrl + '/posts/$postId'),
      body: jsonBody,
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}

class PostRemoteDataSourceImplWithDio implements PostRemoteDataSource {
  @override
  Future<Unit> createPost(PostModel post) {
    // TODO: implement createPost
    throw UnimplementedError();
  }

  @override
  Future<Unit> delete(int postId) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getAllPosts() {
    // TODO: implement getAllPosts
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePost(PostModel post) {
    // TODO: implement updatePost
    throw UnimplementedError();
  }
}

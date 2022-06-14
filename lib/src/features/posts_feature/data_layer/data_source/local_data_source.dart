import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tdd_app/src/core/errors/exceptions.dart';
import '../../../../core/constants/cache_keys.dart';
import '../models/post_model.dart';

abstract class PostLocalDataSource {
  Future<List<PostModel>> getCachedPosts();

  Future<Unit> cachePosts(List<PostModel> posts);
}

class PostLocalDataSourceImplWithSharedPreferences
    implements PostLocalDataSource {
  final SharedPreferences preferences;

  PostLocalDataSourceImplWithSharedPreferences({required this.preferences});

  @override
  Future<Unit> cachePosts(List<PostModel> posts) async {
    List<dynamic> jsonPosts =
        posts.map<Map<String, dynamic>>((element) => element.toJson()).toList();
    await preferences.setString(cachedPosts, json.encode(jsonPosts));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCachedPosts() async {
    final String? jsonString = preferences.getString(cachedPosts);
    if (jsonString != null) {
      final List<dynamic> jsonPosts = json.decode(jsonString);
      final List<PostModel> posts = jsonPosts
          .map<PostModel>((element) => PostModel.fromJson(element))
          .toList();
      return Future.value(posts);
    } else {
      throw CacheException();
    }
  }
}

class PostLocalDataSourceImplWithSqlite implements PostLocalDataSource {
  @override
  Future<Unit> cachePosts(List<PostModel> posts) {
    // TODO: implement cachedPosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCachedPosts() {
    // TODO: implement getCachedPosts
    throw UnimplementedError();
  }
}

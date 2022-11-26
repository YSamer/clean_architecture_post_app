// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:clean_architecture_post_app/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:clean_architecture_post_app/features/posts/data/models/post_model.dart';

abstract class RemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> addPost(PostModel postModel);
  Future<Unit> updatePost(PostModel postModel);
  Future<Unit> deletePost(int postId);
}

const String baseUrl = 'https://jsonplaceholder.typicode.com';

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse('$baseUrl/posts/'),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      final List decodeJson = json.decode(response.body) as List;
      final List<PostModel> postModels = decodeJson
          .map<PostModel>((jsonPostModel) => PostModel.fromJson(jsonPostModel))
          .toList();
      return postModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response =
        await client.post(Uri.parse('$baseUrl/posts/'), body: body);

    if (response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response = await client.delete(
      Uri.parse('$baseUrl/posts/$postId'),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> updatePost(PostModel postModel) async {
    final body = {
      "title": postModel.title,
      "body": postModel.body,
    };
    final response = await client
        .patch(Uri.parse('$baseUrl/posts/${postModel.id}'), body: body);
    if (response.statusCode == 200) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}

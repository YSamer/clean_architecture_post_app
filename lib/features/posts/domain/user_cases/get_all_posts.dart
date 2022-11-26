import 'package:clean_architecture_post_app/core/error/failures.dart';
import 'package:clean_architecture_post_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUserCase {
  final PostsRepository repository;
  GetAllPostsUserCase({
    required this.repository,
  });

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}

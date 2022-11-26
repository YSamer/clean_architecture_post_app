import 'package:clean_architecture_post_app/core/error/failures.dart';
import 'package:clean_architecture_post_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUserCase {
  final PostsRepository repository;
  UpdatePostUserCase({
    required this.repository,
  });

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}

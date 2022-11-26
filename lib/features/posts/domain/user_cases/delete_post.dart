import 'package:clean_architecture_post_app/core/error/failures.dart';
import 'package:clean_architecture_post_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:dartz/dartz.dart';

class DeletePostUserCase {
  final PostsRepository repository;
  DeletePostUserCase({
    required this.repository,
  });

  Future<Either<Failure, Unit>> call(int postId) async {
    return await repository.deletePost(postId);
  }
}

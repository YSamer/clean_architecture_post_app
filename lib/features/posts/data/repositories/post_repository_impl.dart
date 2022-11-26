import 'package:clean_architecture_post_app/core/error/exceptions.dart';
import 'package:clean_architecture_post_app/core/network/network_info.dart';
import 'package:clean_architecture_post_app/features/posts/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_architecture_post_app/core/error/failures.dart';
import 'package:clean_architecture_post_app/features/posts/data/data_sources/local_data_source.dart';
import 'package:clean_architecture_post_app/features/posts/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_post_app/features/posts/domain/entities/post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/repositories/posts_repository.dart';

typedef PostActions = Future<Unit> Function();

class PostsRepositoryImpl implements PostsRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  PostsRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await networkInfo.isNetworkConnected) {
      try {
        final remotePosts = await remoteDataSource.getAllPosts();
        localDataSource.cachePosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await localDataSource.getCachedPosts();
        return Right(localPosts);
      } on EmptyCacheException {
        return Left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel = PostModel(
      title: post.title,
      body: post.body,
    );

    return await getMessage(() {
      return remoteDataSource.addPost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postModel = PostModel(
      id: post.id,
      title: post.title,
      body: post.body,
    );

    return await getMessage(() {
      return remoteDataSource.updatePost(postModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await getMessage(() {
      return remoteDataSource.deletePost(postId);
    });
  }

  Future<Either<Failure, Unit>> getMessage(
      PostActions postAction) async {
    if (await networkInfo.isNetworkConnected) {
      try {
        await postAction();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

import 'package:clean_architecture_post_app/core/network/network_info.dart';
import 'package:clean_architecture_post_app/features/posts/data/data_sources/local_data_source.dart';
import 'package:clean_architecture_post_app/features/posts/data/data_sources/remote_data_source.dart';
import 'package:clean_architecture_post_app/features/posts/data/repositories/post_repository_impl.dart';
import 'package:clean_architecture_post_app/features/posts/domain/repositories/posts_repository.dart';
import 'package:clean_architecture_post_app/features/posts/domain/user_cases/add_post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/user_cases/delete_post.dart';
import 'package:clean_architecture_post_app/features/posts/domain/user_cases/update_post.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/bloc/get_posts/get_posts_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/bloc/post_actions/post_actions_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'features/posts/domain/user_cases/get_all_posts.dart';

final inj = GetIt.instance;

Future<void> init() async {
  // BLoC
  inj.registerFactory(() => GetPostsBloc(getAllPosts: inj()));
  inj.registerFactory(() => PostActionsBloc(
        addPost: inj(),
        updatePost: inj(),
        deletePost: inj(),
      ));

  // User Cases
  inj.registerLazySingleton(() => GetAllPostsUserCase(repository: inj()));
  inj.registerLazySingleton(() => AddPostUserCase(repository: inj()));
  inj.registerLazySingleton(() => UpdatePostUserCase(repository: inj()));
  inj.registerLazySingleton(() => DeletePostUserCase(repository: inj()));

  // Repo
  inj.registerLazySingleton<PostsRepository>(() => PostsRepositoryImpl(
      remoteDataSource: inj(), localDataSource: inj(), networkInfo: inj()));
  // Data Sources
  inj.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: inj()));
  inj.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(client: inj()));

  // Core
  inj.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(connectionChecker: inj()));
  // Base
  final sharedPreferences = await SharedPreferences.getInstance();
  inj.registerLazySingleton(() => sharedPreferences);
  inj.registerLazySingleton(() => http.Client());
  inj.registerLazySingleton(() => InternetConnectionChecker());
}

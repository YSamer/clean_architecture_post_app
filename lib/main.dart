import 'package:clean_architecture_post_app/core/app_theme.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/bloc/get_posts/get_posts_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/bloc/post_actions/post_actions_bloc.dart';
import 'package:clean_architecture_post_app/features/posts/presentation/pages/posts_page.dart';
import 'package:clean_architecture_post_app/injections.dart' as dep_inj;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep_inj.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              dep_inj.inj<GetPostsBloc>()..add(GetAllPostsEvent()),
        ),
        BlocProvider(
          create: (context) => dep_inj.inj<PostActionsBloc>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Post App',
        theme: appTheme,
        home: const PostsPage(),
      ),
    );
  }
}

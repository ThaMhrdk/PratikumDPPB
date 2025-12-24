import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import '../mvc/auth/bloc/auth_bloc.dart';
import '../mvc/auth/data/auth_repository.dart';
import '../mvc/auth/data/auth_storage.dart';
import '../mvc/auth/view/login_page.dart';
import '../mvc/auth/view/register_page.dart';
import '../mvc/posts/bloc/post_bloc.dart';
import '../mvc/posts/data/post_repository.dart';
import '../mvc/posts/view/post_page.dart';

class AppRouter {
  AppRouter({
    required this.authRepository,
    required this.authStorage,
    required this.postRepository,
  });

  final AuthRepository authRepository;
  final AuthStorage authStorage;
  final PostRepository postRepository;

  Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case PostPage.routeName:
      case '/':
        return MaterialPageRoute(
          builder: (_) => RepositoryProvider.value(
            value: postRepository,
            child: BlocProvider(
              create: (_) => PostBloc(postRepository)..add(const PostFetched()),
              child: const PostPage(),
            ),
          ),
        );
      case LoginPage.routeName:
        return MaterialPageRoute(
          builder: (_) => MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: authRepository),
              RepositoryProvider.value(value: authStorage),
            ],
            child: BlocProvider(
              create: (_) => AuthBloc(
                authRepository: authRepository,
                authStorage: authStorage,
              ),
              child: const LoginPage(),
            ),
          ),
        );
      case RegisterPage.routeName:
        return MaterialPageRoute(
          builder: (_) => MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: authRepository),
              RepositoryProvider.value(value: authStorage),
            ],
            child: BlocProvider(
              create: (_) => AuthBloc(
                authRepository: authRepository,
                authStorage: authStorage,
              ),
              child: const RegisterPage(),
            ),
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Route not found'))),
        );
    }
  }
}

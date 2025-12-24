import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';
import 'core/app_router.dart';
import 'core/dio_client.dart';
import 'mvc/auth/bloc/auth_bloc.dart';
import 'mvc/auth/data/auth_repository.dart';
import 'mvc/auth/data/auth_storage.dart';
import 'mvc/auth/view/login_page.dart';
import 'mvc/auth/view/register_page.dart';
import 'mvc/posts/bloc/post_bloc.dart';
import 'mvc/posts/data/post_repository.dart';
import 'mvc/posts/view/post_page.dart';
import 'mvc/posts/view/post_form_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = CustomHttpOverrides();

  // GANTI IP INI DENGAN IP LAPTOP ANDA YANG TERBARU
  const baseUrl = 'http://192.168.137.1:8000/api';

  final authStorage = AuthStorage();
  final token = await authStorage.getToken();
  final dioClient = DioClient(baseUrl: baseUrl, token: token);
  final authRepository = AuthRepository(dioClient);
  final postRepository = PostRepository(dioClient);

  final appRouter = AppRouter(
    authRepository: authRepository,
    authStorage: authStorage,
    postRepository: postRepository,
  );

  runApp(
    MyApp(
      appRouter: appRouter,
      authRepository: authRepository,
      authStorage: authStorage,
      postRepository: postRepository,
      dioClient: dioClient,
      initialToken: token,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.appRouter,
    required this.authRepository,
    required this.authStorage,
    required this.postRepository,
    required this.dioClient,
    this.initialToken,
  });

  final AppRouter appRouter;
  final AuthRepository authRepository;
  final AuthStorage authStorage;
  final PostRepository postRepository;
  final DioClient dioClient;
  final String? initialToken;

  // 1. TAMBAHKAN KEY UNTUK NAVIGATOR
  static final GlobalKey<NavigatorState> _navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: authStorage),
        RepositoryProvider.value(value: postRepository),
        RepositoryProvider.value(value: dioClient),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthBloc(
              authRepository: authRepository,
              authStorage: authStorage,
            )..add(const AuthCheckRequested()),
          ),
          BlocProvider(create: (_) => PostBloc(postRepository)),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state.status == AuthStatus.authenticated) {
              authStorage.getToken().then((token) {
                if (token != null) {
                  dioClient.updateToken(token);
                }
              });
              final successMsg = state.message ?? 'Login berhasil';
              _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
              _scaffoldMessengerKey.currentState?.showSnackBar(
                SnackBar(
                  content: Text(successMsg),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Colors.green[600],
                ),
              );

              // 2. GUNAKAN KEY UNTUK NAVIGASI (Bukan context)
              Future.delayed(const Duration(milliseconds: 200), () {
                try {
                  _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                    '/posts',
                    (Route<dynamic> route) => false,
                  );
                } catch (e) {
                  print('Navigator error: $e');
                }
              });
            } else if (state.status == AuthStatus.unauthenticated) {
              dioClient.clearToken();
              if (state.message != null && state.message!.isNotEmpty) {
                final msg = state.message!;
                final isLogoutMessage = msg.contains('Logout');
                _scaffoldMessengerKey.currentState?.removeCurrentSnackBar();
                _scaffoldMessengerKey.currentState?.showSnackBar(
                  SnackBar(
                    content: Text(msg),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: isLogoutMessage
                        ? Colors.green[600]
                        : Colors.red[700],
                  ),
                );
              }

              // 3. GUNAKAN KEY UNTUK NAVIGASI SAAT LOGOUT
              Future.microtask(() {
                _navigatorKey.currentState?.pushNamedAndRemoveUntil(
                  '/',
                  (Route<dynamic> route) => false,
                );
              });
            }
          },
          child: MaterialApp(
            title: 'Flutter Laravel API',
            debugShowCheckedModeBanner: false,
            // 4. PASANG NAVIGATOR KEY DI SINI
            navigatorKey: _navigatorKey,
            scaffoldMessengerKey: _scaffoldMessengerKey,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
              useMaterial3: true,
            ),
            initialRoute: '/',
            routes: {
              '/': (context) => BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state.status == AuthStatus.loading ||
                      state.status == AuthStatus.initial) {
                    return const Scaffold(
                      body: Center(child: CircularProgressIndicator()),
                    );
                  } else if (state.status == AuthStatus.authenticated) {
                    return BlocProvider.value(
                      value: context.read<PostBloc>()..add(const PostFetched()),
                      child: const PostPage(),
                    );
                  } else {
                    return const LoginPage();
                  }
                },
              ),
              '/login': (context) => const LoginPage(),
              '/register': (context) => const RegisterPage(),
              '/posts': (context) => const PostPage(),
              '/post-form': (context) => const PostFormPage(),
            },
          ),
        ),
      ),
    );
  }
}

class CustomHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..connectionTimeout = const Duration(seconds: 30)
      ..findProxy = HttpClient.findProxyFromEnvironment;
  }
}

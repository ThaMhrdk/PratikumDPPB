import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'chart/cart_cubit.dart';
import 'pages/home_page.dart';
import 'pages/cart_page.dart';
import 'pages/about_page.dart';

void main() {
  runApp(BlocProvider(create: (_) => CartCubit(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Online Sederhana',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/cart': (context) => const CartPage(),
        '/about': (context) => const AboutPage(),
      },
    ); // MaterialApp
  }
}

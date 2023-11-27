// ignore_for_file: use_build_context_synchronously

import 'package:authuz/pages/chacker_page.dart';
import 'package:authuz/pages/home_page.dart';
import 'package:authuz/pages/login_page.dart';
import 'package:authuz/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Checker(),
      routes: {
        HomePage.id: (context) => const HomePage(),
        RegisterPage.id: (context) => const RegisterPage(),
        LoginPage.id: (context) => const LoginPage(),
      },
    );
  }
}

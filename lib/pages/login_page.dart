// ignore_for_file: use_build_context_synchronously

import 'package:authuz/models/user_model.dart';
import 'package:authuz/pages/home_page.dart';
import 'package:authuz/services/api_services.dart';
import 'package:authuz/services/navigator_services.dart';
import 'package:authuz/services/storage_services.dart';
import 'package:authuz/widgets/app_button.dart';
import 'package:authuz/widgets/app_text_field.dart';
import 'package:authuz/widgets/sized_boxes.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  static const String id = "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() async {
    UserModel user = UserModel(
      password: passwordController.text.trim(),
      username: usernameController.text.trim(),
    );
    final response = await ApiServices.loginUser(user);
    if (response != null) {
      await StorageServices.write(response);
      navigateID(HomePage.id, context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Xatolik!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 40, right: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HBox(100),
              const Text(
                "Login",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                ),
              ),
              HBox(32),
              AppTextField(
                title: "Enter username",
                controller: usernameController,
              ),
              HBox(16),
              AppTextField(
                title: "Enter password",
                controller: passwordController,
              ),
              HBox(24),
              AppButton(
                title: "Login user",
                onTap: () {
                  login();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:authuz/pages/home_page.dart';
import 'package:authuz/pages/register_page.dart';
import 'package:authuz/services/navigator_services.dart';
import 'package:authuz/services/storage_services.dart';
import 'package:flutter/material.dart';

class Checker extends StatefulWidget {
  const Checker({super.key});

  @override
  State<Checker> createState() => _CheckerState();
}

class _CheckerState extends State<Checker> {
  void initApp() async {
    final token = await StorageServices.read();
    if (token != null) {
      navigateID(HomePage.id, context);
    } else {
      navigateID(RegisterPage.id, context);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initApp();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(
            strokeWidth: 8,
            color: Colors.deepPurple,
          ),
        ),
      ),
    );
  }
}

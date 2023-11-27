import 'package:authuz/pages/register_page.dart';
import 'package:authuz/services/navigator_services.dart';
import 'package:authuz/services/storage_services.dart';
import 'package:authuz/widgets/app_button.dart';
import 'package:authuz/widgets/sized_boxes.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const String id = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    logout() async {
      StorageServices.delete();
      navigateID(RegisterPage.id, context);
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "Here is Home Page",
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
            HBox(24),
            AppButton(
              title: "Logout",
              onTap: () {
                logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}

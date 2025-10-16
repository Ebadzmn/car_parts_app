import 'package:car_parts_app/core/config/assets_path.dart';
import 'package:car_parts_app/core/coreWidget/custom_text_widget.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AssetsPath.logo),
            CustomTextField(
              label: 'Email',
              hintText: 'Please enter your email address',
            ),
          ],
        ),
      ),
    );
  }
}

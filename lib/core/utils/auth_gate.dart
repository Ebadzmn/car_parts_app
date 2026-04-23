import 'dart:async';

import 'package:car_parts_app/core/appRoutes/app_routes.dart';
import 'package:car_parts_app/core/injector/injector.dart';
import 'package:car_parts_app/data/data_source/local/auth_local_datasource.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

const Set<String> protectedRoutePaths = {
  AppRoutes.userProfileScreen,
  AppRoutes.uploadProductScreen,
  AppRoutes.SellarScreen,
  AppRoutes.Myproduct,
  AppRoutes.AddNewCategoryScreen,
  AppRoutes.NotificationScreen,
  AppRoutes.reviewScreen,
  AppRoutes.changeBasicInfo,
  AppRoutes.changeContact,
  AppRoutes.changePassword,
};

bool isProtectedPath(String path) => protectedRoutePaths.contains(path);

String buildLoginLocation(String intendedLocation) {
  return '${AppRoutes.LoginPage}?from=${Uri.encodeComponent(intendedLocation)}';
}

Future<bool> hasAuthToken() async {
  final authLocal = sl<AuthLocalDatasource>();
  final token = await authLocal.getToken();
  return token != null && token.isNotEmpty;
}

Future<void> redirectToLogin(
  BuildContext context, {
  required String intendedLocation,
  String message = 'Login to continue',
}) async {
  if (!context.mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message), duration: const Duration(seconds: 2)),
  );

  await Future<void>.delayed(const Duration(milliseconds: 150));

  if (context.mounted) {
    context.push(buildLoginLocation(intendedLocation));
  }
}
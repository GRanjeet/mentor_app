import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/routes/app_routes.dart';

class SplashView extends StatelessWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.loginRoute));
    return Scaffold(
      body: Center(
        child: Icon(
          Icons.school_rounded,
          color: Colors.blue,
          size: 56,
        ),
      ),
    );
  }
}

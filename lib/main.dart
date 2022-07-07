import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/routes/app_pages.dart';
import 'package:mentor_app/theme/app_theme.dart';

import 'firebase_options.dart';
import 'modules/splash/splash_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentor App',
      theme: AppTheme.themeData,
      getPages: AppPages.pages,
      home: SplashView(),
    );
  }
}

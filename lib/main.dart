import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'modules/splash/splash_view.dart';
import 'routes/app_pages.dart';
import 'theme/app_theme.dart';

void main() async {
  // Comment:  Firebase Initializations when the app starts.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Comment:  Loads the MyApp views.
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Comment:  It builds upon a WidgetsApp by adding material-design specific functionality.
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mentor App',
      theme: AppTheme.themeData,
      getPages: AppPages.pages,
      home: SplashView(),
    );
  }
}

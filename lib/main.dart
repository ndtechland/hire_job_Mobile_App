import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hirejobindia/controllers/nav_bar_controller/nav_controller.dart';
import 'package:hirejobindia/modules/components/styles.dart';
import 'package:hirejobindia/modules/splash_screen/splash_screen.dart';

//import 'package:suvidha_app_ui/constants/language_string/language_text.dart';
//import 'package:suvidha_app_ui/screens/welcome_page.dart';
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "regular",
        primaryColor: appColor,
        backgroundColor: appColor,
        dividerColor: Colors.transparent,
      ),
      home: Scaffold(
        body: SplashScreen(),
      ),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<BottomNavigationBarController>(
            () => BottomNavigationBarController());
      }),
    );
  }
}

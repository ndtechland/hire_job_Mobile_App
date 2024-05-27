import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hirejobindia/controllers/nav_bar_controller/nav_controller.dart';
import 'package:hirejobindia/modules/components/styles.dart';

import 'controllers/view_job_controller/job_controllersss.dart';
import 'modules/splash_screen/splash_screen.dart';
// Import the AllJibsController
//import 'package:hirejobindia/controllers/all_jibs_controller.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global =
      MyHttpOverrides(); // Don't forget to set the HttpOverrides

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
        body:

            ///PaymentScreen(),

            SplashScreen(),
      ),
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<BottomNavigationBarController>(
            () => BottomNavigationBarController());
        Get.lazyPut<AllJibsController>(
            () => AllJibsController()); //AllcompanyController
        // Add initialization for AllJibsController here
        Get.lazyPut<AllJibsController>(() => AllJibsController());
      }),
    );
  }
}

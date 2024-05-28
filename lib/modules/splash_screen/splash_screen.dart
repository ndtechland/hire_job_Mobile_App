import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirejobindia/modules/all_pages/pages/slider.dart';

import '../../controllers/splash_controller/splash_controllers.dart';
import '../../controllers/user_profile_controller/user_profile_controller.dart';
import '../../services_apis/autologin_services.dart';
import '../all_pages/pages/home.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);

  final ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenControllers>(
        init: SplashScreenControllers(),
        builder: (controller) {
          if (controller.animation.status == AnimationStatus.completed) {
            // Start the timer
            Timer(Duration(seconds: 2), () async {
              final accountData = await accountService.getAccountData;
              print("AccountData: $accountData");

              if (accountData == null) {
                await _profileController.profileApi();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SliderScreen()),
                );
              } else {
                await _profileController.profileApi();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Home()),
                );
              }
            });
          }

          return Center(
            child: AnimatedBuilder(
              animation: controller.animation,
              builder: (context, child) {
                return Transform.scale(
                  scale: controller.animation.value * 2,
                  child: Image.asset(
                    'lib/assets/logo/hirelogo.png',
                    width: 150,
                    height: 200,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

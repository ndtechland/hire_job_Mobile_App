import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirejobindia/modules/all_pages/pages/slider.dart';

import '../../controllers/splash_controller/splash_controllers.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<SplashScreenControllers>(
        init: SplashScreenControllers(),
        builder: (controller) {
          // Assuming you want to navigate after animation completes
          if (controller.animation.status == AnimationStatus.completed) {
            // Navigate to HomeScreen
            Future.delayed(Duration.zero, () {
              Get.off(SliderScreen());
            });
          }
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  AnimatedBuilder(
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
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

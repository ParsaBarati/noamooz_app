import 'package:flutter/material.dart';
import 'package:noamooz_app/Controllers/Splash/splash_controller.dart';
import 'package:noamooz_app/Plugins/get/get.dart';
import 'package:noamooz_app/Utils/color_utils.dart';

class SplashScreen extends StatelessWidget {
  final SplashController controller = Get.put(
    SplashController(),
  );
  SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorUtils.black,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Center(
          child: Image.asset(
            'assets/img/logo.png',
          ),
        ),
      ),
    );
  }
}

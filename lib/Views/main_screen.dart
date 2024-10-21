import 'package:noamooz_app/Controllers/Login/login_controller.dart';
import 'package:noamooz_app/Controllers/Profile/profile_controller.dart';
import 'package:noamooz_app/Controllers/Wallet/wallet_controller.dart';
import 'package:noamooz_app/Views/Index/Index_screen.dart';
import 'package:noamooz_app/Views/Login/login_screen.dart';
import 'package:noamooz_app/Views/MyCourses/my_courses_screen.dart';
import 'package:noamooz_app/Views/Profile/profile_screen.dart';
import 'package:noamooz_app/Views/Wallet/wallet_screen.dart';
import 'package:noamooz_app/Widgets/my_drawer.dart';
import 'package:noamooz_app/Widgets/nav_bar_widget.dart';
import 'package:flutter/material.dart';

import '../Plugins/get/get.dart';
import '../Widgets/my_app_bar.dart';

class MainScreen extends StatelessWidget {
  final MainGetxController mainController = Get.put(MainGetxController());

  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (mainController.currentIndex != 0) {
          mainController.currentIndex = 0;
          Get.delete<WalletController>();
          Get.delete<ProfileController>();
          Get.delete<LoginController>();
          mainController.update();
          return false;
        }
        return true;
      },
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          resizeToAvoidBottomInset: false,
          drawer: MyDrawer(),
          key: mainController.scaffoldKey,
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              buildPageView(),
              NavBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPageView() {
    return GetBuilder(
      init: mainController,
      builder: (MainGetxController controller) {
        switch (mainController.currentIndex) {
          case 0:
            return IndexScreen();
          case 1:
            return MyCoursesScreen();
          case 2:
            return ProfileScreen();
        }
        return const Scaffold();
      },
    );
  }
}

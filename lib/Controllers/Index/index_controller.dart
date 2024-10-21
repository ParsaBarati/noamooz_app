import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:noamooz_app/Globals/Globals.dart';
import 'package:noamooz_app/Models/Blog/post_model.dart';
import 'package:noamooz_app/Models/Index/banner_model.dart';
import 'package:noamooz_app/Models/Index/home_icon_model.dart';
import 'package:noamooz_app/Models/db_models/home_icons_model.dart';
import 'package:noamooz_app/Plugins/get/get.dart';
import 'package:noamooz_app/Utils/Api/project_request_utils.dart';
import 'package:noamooz_app/Utils/routing_utils.dart';
import 'package:noamooz_app/Utils/view_utils.dart';

class IndexController extends GetxController {
  final RxBool isLoading = true.obs;
  final PageController pageController = PageController();
  List<PostModel> posts = [];
  List<BannerModel> banners = [];
  List<HomeIcon> icons = [];
  Timer? _timer;

  void fetchInit() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
    isLoading.value = true;
    if (!Globals.offlineStream.isOffline) {
      ApiResult result = await RequestsUtil.instance.pages.index();
      if (result.isDone) {
        banners = BannerModel.listFromJson(result.data['banners']);
        icons = HomeIcon.listFromJson(result.data['icons']);
        _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
          pageController.nextPage(
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeIn,
          );
          if (pageController.page == banners.length - 1){
            pageController.animateToPage(0, duration: Duration(milliseconds: 150), curve: Curves.easeIn,);
          }
        });
        try {
          await HomeIconsDbModel().truncate();
          await HomeIconsDbModel().insertAll(icons.map((e) {
            return {
              'content': e.toJson(),
            };
          }).toList());
        } catch (e) {}
      }
    } else {
      List homeIcons = await HomeIconsDbModel().getAll();
      icons = HomeIcon.listFromJson(
          homeIcons.map((e) => jsonDecode(e['content'])).toList());
    }
    isLoading.value = false;
  }

  @override
  void onInit() {
    fetchInit();
    super.onInit();
  }


  void onTap(HomeIcon icon) {
    print(icon.id);
    switch (icon.id) {
      case 1:
        Get.toNamed(RoutingUtils.categories.name, arguments: {
          "free": false,
        });
        break;
      case 2:
        Get.toNamed(RoutingUtils.categories.name, arguments: {
          "free": true,
        });
        break;
      case 3:
        Get.toNamed(RoutingUtils.forums.name);
        break;
      case 4:
        Get.toNamed(RoutingUtils.myCourses.name);
        break;
      case 5:
        Get.toNamed(RoutingUtils.support.name);
        break;
      case 6:
        Get.toNamed(RoutingUtils.quizzes.name);
        break;
      case 7:
        Get.toNamed(RoutingUtils.lotteries.name);
        break;
      case 8:
        Get.toNamed(RoutingUtils.faq.name);
        break;
      default:
        ViewUtils.showErrorDialog("صفحه مورد نظر در حال طراحی است");
        break;
    }
  }
}

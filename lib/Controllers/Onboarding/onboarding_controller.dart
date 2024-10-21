import 'package:flutter/material.dart';
import 'package:noamooz_app/Globals/Globals.dart';
import 'package:noamooz_app/Models/on_boarding_page_model.dart';
import 'package:noamooz_app/Models/user_model.dart';
import 'package:noamooz_app/Utils/Api/project_request_utils.dart';
import 'package:noamooz_app/Utils/routing_utils.dart';
import 'package:noamooz_app/Utils/storage_utils.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../Plugins/get/get.dart';

class OnBoardingController extends GetxController {
  final RxBool isLoaded = false.obs;
  List<OnBoardingPageModel> pages = [];
  final PageController pageController = PageController();
  final RxInt page = 0.obs;
  @override
  void onInit() {
    fetchPages();
    super.onInit();
  }

  void fetchPages() async {
    ApiResult result = await RequestsUtil.instance.pages.onBoarding();
    if (result.isDone){
      pages = OnBoardingPageModel.listFromJson(result.data);
      if (pages.isNotEmpty) {
        isLoaded.value = true;
      } else {
        Get.offAllNamed(RoutingUtils.login.name,);
      }
    } else {
      Get.offAllNamed(RoutingUtils.login.name,);
    }
  }
}

import 'package:flutter/cupertino.dart';
import 'package:noamooz_app/Models/Courses/course_model.dart';
import 'package:noamooz_app/Models/general_item_model.dart';
import 'package:noamooz_app/Plugins/get/get.dart';
import 'package:noamooz_app/Utils/Api/project_request_utils.dart';

class CoursesController extends GetxController {
  final RxBool isLoading = false.obs;
  List<CourseModel> _courses = [];
  GeneralInformationModel? category;

  List<CourseModel> get courses => _courses
      .where((element) => searchController.text.trim().isEmpty ? true : element.name.contains(searchController.text.trim()))
      .toList();

  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    fetchCourses();
    super.onInit();
  }

  void fetchCourses() async {
    isLoading.value = true;
    ApiResult result = await RequestsUtil.instance.pages
        .courses(Get.currentRoute.split('/').last);
    if (result.isDone) {
      category = GeneralInformationModel.fromJson(result.data['category']);
      _courses = CourseModel.listFromJson(result.data['courses']);
    }
    isLoading.value = false;
  }
}

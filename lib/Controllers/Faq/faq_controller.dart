import 'package:noamooz_app/Models/Faq/faq_model.dart';
import 'package:noamooz_app/Plugins/get/get.dart';
import 'package:noamooz_app/Utils/Api/project_request_utils.dart';

class FaqController extends GetxController {
  final RxBool isLoading = true.obs;

  List<FaqType> faqs = [];


  @override
  void onInit() {
    fetchFaq();
    super.onInit();
  }

  void fetchFaq() async {
    isLoading.value = true;
    ApiResult result = await RequestsUtil.instance.faq.list();
    if (result.isDone) {
      faqs = FaqType.listFromJson(result.data);
    }
    isLoading.value = false;
  }
}
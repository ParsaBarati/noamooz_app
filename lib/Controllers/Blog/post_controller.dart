import 'package:noamooz_app/Models/Blog/post_model.dart';
import 'package:noamooz_app/Plugins/get/get.dart';
import 'package:noamooz_app/Utils/Api/project_request_utils.dart';

class PostController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool isMoreLoading = false.obs;
  List<PostModel> posts = [];
  int page = 0;



  void fetchPosts() async {
    isLoading.value = true;
    ApiResult apiResult = await RequestsUtil.instance.blog.posts(page);
    if (apiResult.isDone) {
      posts = PostModel.listFromJson(apiResult.data);
    }
    isLoading.value = false;
  }

  void fetchMorePosts() async {
    page++;
    isMoreLoading.value = true;
    ApiResult apiResult = await RequestsUtil.instance.blog.posts(page);
    if (apiResult.isDone) {
      posts.addAll(PostModel.listFromJson(apiResult.data));
    }
    isMoreLoading.value = true;
  }

  @override
  void onInit() {
    fetchPosts();
    super.onInit();
  }
}

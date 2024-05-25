import 'package:get/get.dart';

import '../../models/all_catagary.dart';
import '../../models/all_jobs_model.dart';
import '../../services_apis/api_servicesss.dart';

class HomePageController extends GetxController {
  var isLoading = true.obs;
  PostedByModel? allcatApiModel;
  AllJobsApiModel? allJobsApiModel;

  String searchQuery = "";

  ///todo: all catagary...
  void catagoryListApi2() async {
    isLoading(true);
    allcatApiModel = await ApiProvider.AllcatagoryApi();
    print('Prince doctor list');
    print(allcatApiModel);
    if (allcatApiModel!.getPostedbyList != null) {
      //Get.to(() => TotalPrice());
      isLoading(false);
      //Get.to(()=>Container());
    }
  }

  void jobListApi2() async {
    isLoading(true);
    allJobsApiModel = await ApiProvider.AllJobsApi();
    print('Prince doctor list');
    print(allJobsApiModel);
    if (allJobsApiModel != null) {
      //Get.to(() => TotalPrice());
      isLoading(false);
      //Get.to(()=>Container());
    }
  }

  //RxList<GetAllCatList> foundcatagory = RxList<GetAllCatList>([]);

  @override
  void onInit() {
    super.onInit();
    catagoryListApi2();
    jobListApi2();
  }
}

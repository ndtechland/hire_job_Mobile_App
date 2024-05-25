import 'package:get/get.dart';

import '../../models/all_jobs_model.dart';
import '../../services_apis/api_servicesss.dart'; // Import your ApiProvider

class AllJibsController extends GetxController {
  RxBool isLoading = true.obs;
  //List<AllJobsApiModel> allJobs = [];

  AllJobsApiModel? allJobsApiModel;

  final ApiProvider _apiProvider = ApiProvider(); // Use ApiProvider instance
  String searchQuery = "";

  void jobListApi() async {
    isLoading(true);
    allJobsApiModel = await ApiProvider.AllJobsApi();
    print('Prince doctor list');
    print(allJobsApiModel);
    if (allJobsApiModel != null) {
      //Get.to(() => TotalPrice());
      isLoading(false);
      foundJobs.value = allJobsApiModel!.response!;
      //Get.to(()=>Container());
    }
  }

  @override
  void onInit() {
    super.onInit();
    jobListApi();
  }

  RxList<JobResponse> foundJobs = RxList<JobResponse>([]);
  void filterDoctor(String searcjonName) {
    List<JobResponse>? finalResult = [];
    if (searcjonName.isEmpty) {
      finalResult = allJobsApiModel!.response;
    } else {
      finalResult = allJobsApiModel!.response!
          .where((element) => element.jobTitle
              .toString()
              .toLowerCase()
              .contains(searcjonName.toString().toLowerCase().trim()))
          .toList();
    }
    print(finalResult?.length);
    foundJobs.value = finalResult!;
  }

  void applyForJob(AllJobsApiModel job) {
    // Implement apply for job functionality
  }
}

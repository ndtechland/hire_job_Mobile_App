import 'package:get/get.dart';
import 'package:hirejobindia/models/saved_job_model.dart';

import '../../models/all_jobs_model.dart';
import '../../services_apis/api_servicesss.dart'; // Import your ApiProvider

class AllJibsController extends GetxController {
  RxBool isLoading = true.obs;
  //List<AllJobsApiModel> allJobs = [];

  AllJobsApiModel? allJobsApiModel;
  AllJobsSavedApiModel? savejobapimodel;

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

  void savedjobListApi() async {
    isLoading(true);
    savejobapimodel = await ApiProvider.AllSavedJobsApi();
    print('Prince doctor list');
    print(savejobapimodel);
    if (savejobapimodel != null) {
      //Get.to(() => TotalPrice());
      isLoading(false);
      foundSavedJobs.value = savejobapimodel!.response!;
      //Get.to(()=>Container());
    }
  }

  @override
  void onInit() {
    super.onInit();
    jobListApi();
    savedjobListApi();
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

  RxList<JobResponseSaved> foundSavedJobs = RxList<JobResponseSaved>([]);
  void filterSavedJob(String searchsavejobName) {
    List<JobResponseSaved>? finalResult = [];
    if (searchsavejobName.isEmpty) {
      finalResult = savejobapimodel!.response;
    } else {
      finalResult = savejobapimodel!.response!
          .where((element) => element.jobTitle
              .toString()
              .toLowerCase()
              .contains(searchsavejobName.toString().toLowerCase().trim()))
          .toList();
    }
    print(finalResult?.length);
    foundSavedJobs.value = finalResult!;
  }

  void applyForJob(AllJobsApiModel job) {
    // Implement apply for job functionality
  }
}

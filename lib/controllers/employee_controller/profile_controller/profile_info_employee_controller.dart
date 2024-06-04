import 'dart:async';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hirejobindia/services_apis/api_servicesss.dart';

import '../../../models/employee_model/profile_model/profile_info_model_personal.dart';

class ProfileEmployeeController extends GetxController {
  RxBool isLoading = true.obs;

  RxString cvUrl = ''.obs;

  GetProfileEmployeePersonalModel? getprofileemployeeModel;

  Future<void> profileemployeeApi() async {
    isLoading(true);
    getprofileemployeeModel = await ApiProvider.PriofilePersonalEmployeeApi();

    if (getprofileemployeeModel?.data?.personalEmailAddress == null) {
      Timer(
        const Duration(seconds: 1),
        () {
          //Get.snackbar("Fail", "${medicinecheckoutModel?.data}");
          //Get.to(() => MedicineCart());
          //Get.to((page))
          ///
        },
      );
      isLoading(true);
      getprofileemployeeModel = await ApiProvider.PriofileApi();
    }
    if (getprofileemployeeModel?.data?.personalEmailAddress != null) {
      //Get.to(() => TotalPrice());
      isLoading(false);
    }
  }

  @override
  void onInit() {
    super.onInit();
    profileemployeeApi();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

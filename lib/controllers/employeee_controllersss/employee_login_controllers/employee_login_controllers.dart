import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../models/autologin_account_model.dart';
import '../../../modules/all_pages/pages/emploree_pages/home_page_employee.dart';
import '../../../services_apis/api_servicesss.dart';
import '../../../services_apis/autologin_services.dart';
import '../profile_employee_controller/employee_profile_controller.dart';

class EmployeeLoginController extends GetxController {
  final EmployeeProfileController _employeeprofileController =
      Get.put(EmployeeProfileController());

  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;

  Future<void> loginemployeeApi() async {
    try {
      isLoading.value = true;

      final response = await ApiProvider.EmployeeLoginApi(
        usernameController.text,
        passwordController.text,
      );

      if (response.statusCode == 200) {
        await _employeeprofileController.profileApi();
        _employeeprofileController.update();

        final accountData = messageFromJson(response.body);
        await accountService.setAccountData(accountData);

        Get.off(() => HomeEmployee());
      } else {
        Get.snackbar('Error', 'Failed to login. Please try again.');
      }
    } catch (e) {
      print('Error during login: $e');
      Get.off(() => HomeEmployee());

      // Get.snackbar('Error', 'An unexpected error occurred. Please try again.');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize controllers, listeners, etc.
  }

  String? validateUser(String value) {
    if (value.isEmpty) {
      return 'Please provide a username';
    }
    return null;
  }

  String? validatePassword(String value) {
    if (value.length < 4) {
      return 'Please provide a valid password';
    }
    return null;
  }

  void checkemployeeLogin() {
    if (loginFormKey.currentState!.validate()) {
      loginFormKey.currentState!.save();
      loginemployeeApi();
    }
  }
}

import 'dart:typed_data';

import 'package:get/get.dart';

import '../../services_apis/api_servicesss.dart';

class RegistrationController extends GetxController {
  final isLoading = false.obs;

  Future<void> createProfile({
    required String fullName,
    required String emailID,
    required String password,
    required String mobileNumber,
    required String experience,
    required String stateId,
    required String cityId,
    required String genderName,
    required String dateOfBirth,
    required String address,
    required String pincode,
    required Uint8List cvFileContent,
    required String cvFileName, // Add this parameter
  }) async {
    try {
      isLoading(true);

      final Map<String, String> formData = {
        'FullName': fullName,
        'EmailID': emailID,
        'Password': password,
        'MobileNumber': mobileNumber,
        'Experience': experience,
        'StateId': stateId,
        'CityId': cityId,
        'GenderName': genderName,
        'Dateofbirth': dateOfBirth,
        'Address': address,
        'Pincode': pincode,
      };

      // Make API call
      final response =
          await ApiProvider.createProfile(formData, cvFileContent, cvFileName);

      if (response.statusCode == 200) {
        print('Profile created successfully!');
        print(response.body);
      } else {
        print('Error creating profile: ${response.statusCode}');
      }
    } catch (error) {
      print('Network error: $error');
    } finally {
      isLoading(false);
    }
  }
}

import 'package:get/get.dart';

import '../../services_apis/api_servicesss.dart';

class RegistrationController extends GetxController {
  final isLoading = false.obs;

  Future<void> createProfile({
    required String FullName,
    required String EmailID,
    required String password,
    required String mobileNumber,
    required String experience,
    required String stateId,
    required String cityId,
    required String genderName,
    required String dateOfBirth,
    required String address,
    required String pincode,
    required String cvFilePath,
  }) async {
    try {
      isLoading(true);

      final Map<String, dynamic> formData = {
        'FullName': FullName,
        'EmailID': EmailID,
        'Password': password,
        'MobileNumber': mobileNumber,
        'Experience': experience,
        'StateId': stateId,
        'CityId': cityId,
        'GenderName': genderName,
        'Dateofbirth':
            //"2024-05-24T00:00:00",
            dateOfBirth,
        'Address': address,
        'Pincode': pincode,
      };

      // Perform file upload here, and add the CV file to the form data
      // For simplicity, I'm assuming cvFilePath is the file path of the CV file

      // Add CV file to formData
      formData['CVFileName'] = cvFilePath;

      // Make API call
      final response = await ApiProvider.createProfile(formData);
      print("kdsdf");

      print(formData);

      if (response.statusCode == 200) {
        // Handle success
        print('Profile created successfully!');
      } else {
        // Handle error
        print('Error creating profile: ${response.statusCode}');
      }
    } catch (error) {
      // Handle network errors
      print('Network error: $error');
    } finally {
      isLoading(false);
    }
  }
}

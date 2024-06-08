import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hirejobindia/models/all_catagary.dart';
import 'package:hirejobindia/models/applied_job_model.dart';
import 'package:hirejobindia/modules/all_pages/pages/bookmark.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../constants/static_text.dart';
import '../models/all_jobs_model.dart';
import '../models/city_model.dart';
import '../models/company_model.dart';
import '../models/employee_model/all_salary_slip_model.dart';
import '../models/employee_model/dashboard_employee_model.dart';
import '../models/employee_model/offer_appointment_latter_model.dart';
import '../models/employee_model/profile_model/bank_profile_details_employee.dart';
import '../models/employee_model/profile_model/profile_basic_detail_model.dart';
import '../models/employee_model/profile_model/profile_info_model_personal.dart';
import '../models/employee_model/support_comman_model.dart';
import '../models/profile_model.dart';
import '../models/saved_job_model.dart';
import '../models/state_model.dart';
import '../models/testimonial_model.dart';
import '../modules/all_pages/pages/home.dart';

var prefs = GetStorage();

class ApiProvider {
  /// static var baseUrl = 'http://test.pswellness.in/';
  /// "https://api.hirejobindia.com/api/";

  static var baseUrl = FixedText.apiurl;
  //'https://api.hirejobindia.com/api/';

  //http://pswellness.in/
  //static var baseUrl1 = 'https://api.gyros.farm/';
  //'http://pswellness.in/';
  static String token = '';
  //static String Token = '';

  //static String catid = '';
  //static String productid = '';
  //static String orderid = '';
  ///static String Id = '';
  static String MedicineId = ''.toString();
  static String adminId = ''.toString();
  //static String userid = ''.toString();
  static String userId = ''.toString();
  static String employeeId = ''.toString();

  final box = GetStorage();

  ///TODO: here we have to add different api in this page...........
  /// TODO: from here user 1 section...........
  ///
  //user signup..............
  static String apiUrl = "${baseUrl}Login/createProfile";

  static Future<http.Response> createProfile(Map<String, String> formData,
      Uint8List cvFileContent, String cvFileName) async {
    var uri = Uri.parse(apiUrl);
    var request = http.MultipartRequest('POST', uri);

    // Add form fields
    formData.forEach((key, value) {
      request.fields[key] = value;
    });

    // Add file field
    request.files.add(http.MultipartFile.fromBytes(
      'CVFileName', // The name of the file field
      cvFileContent,
      filename: cvFileName, // Use the file name from the parameter
      contentType:
          MediaType('application', 'pdf'), // Use MediaType from http_parser
    ));

    // Send the request
    var response = await request.send();

    // Parse the response
    var httpResponse = await http.Response.fromStream(response);
    if (httpResponse.statusCode == 200) {
      // Assuming the response body contains the user ID in JSON format
      var jsonResponse = jsonDecode(httpResponse.body);
      var userId = jsonResponse['loginProfile']
          ['id']; // Extract the user ID from getData

      // Save the user ID using GetStorage
      final storage = GetStorage();
      storage.write('userId', userId);

      // Print the user ID
      print('Saved user ID: $userId');
      // Show success toast
      Fluttertoast.showToast(
        msg: "Profile created successfully!",
        backgroundColor: Colors.green,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
      );
    } else {
      print(
          'Failed to create profile. Status code: ${httpResponse.statusCode}');

      Fluttertoast.showToast(
        msg:
            "Failed to create profile. Status code: ${httpResponse.statusCode}",
        backgroundColor: Colors.red,
        textColor: Colors.white,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
      );
    }

    return httpResponse;
  }

  ///4.login_email..........post...apis...
  static Future<http.Response> LoginApi(String emailId, String password) async {
    var url = "${baseUrl}Login/ProfileLogin";
    var body = jsonEncode({
      "emailId": emailId,
      "password": password,
    });

    print("loginnnn");
    print(body);

    http.Response r = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(r.body);

    if (r.statusCode == 200) {
      var responseData = json.decode(r.body);
      var userId = responseData['loginProfile']['id'];

      // Save user ID (assuming 'Id' is part of the response JSON)
      prefs.write("Id", userId);
      print('Saved userId: $userId');

      // Navigate to HomePage
      Get.to(() => Home());

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('Message', r.body);
    } else {
      Get.snackbar('Error', r.body);
    }

    return r;
  }

  ///api 1.....all jobs....
  static AllJobsApi() async {
    var url = "${baseUrl}Admin/GetCurrent_Opening";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var GetJobListModel = allJobsApiFromJson(r.body);
        return GetJobListModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///api 2.....all cat....
  ///

  static Future<PostedByModel?> AllcatagoryApi() async {
    var url = "${baseUrl}Admin/FilterData";
    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        return PostedByModel.fromJson(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching categories: $error');
      return null;
    }
  }

  ///api 3.....all com....
  ///

  static Future<CompanyResponse?> AllcompanyApi() async {
    var url = "${baseUrl}App/CompanyList";
    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.body);
      if (response.statusCode == 200) {
        return CompanyResponse.fromJson(jsonDecode(response.body));
      } else {
        print('Request failed with status: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error fetching companies: $error');
      return null;
    }
  }

  ///api 3.....all testimonial.........

  static AllTestimonialApi() async {
    var url = "${baseUrl}Admin/getAllTestimonial";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var GettestimonialModel = allTestimonialModelFromJson(r.body);
        return GettestimonialModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///5.profile_api...
  static PriofileApi() async {
    var prefs = GetStorage();

    //saved userid..........
    //prefs.write("Id".toString(), json.decode(r.body)['Id']);
    userId = prefs.read("Id").toString();
    print('wwwuseridEE:${userId}');
    //https://api.hirejobindia.com/api/App/GetProfile?userId=2
    var url = '${baseUrl}App/GetProfile?userId=$userId';
    try {
      http.Response r = await http.get(Uri.parse(url));
      if (r.statusCode == 200) {
        print("url");
        print(url);
        GetProfileModel? geetprofilemodel = getProfileModelFromJson(r.body);
        print("profile: ${geetprofilemodel.response!.emailId}");
        return geetprofilemodel;
      }
    } catch (error) {
      print('profileedetaileror: $error');
    }
  }

  ///6.job apply successfully..........post...apis...
  static Future<http.Response> ApplyJobAPi(String JobId) async {
    userId = prefs.read("Id").toString();
    print('www:${userId}');
    var url = "${baseUrl}App/Applyjob";
    var body = jsonEncode({
      "JobId": JobId,
      "userID": userId,
    });

    print("jobapply");
    print(body);

    http.Response r = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    print('okapplyjob');
    print(r.body);

    if (r.statusCode == 200) {
      Get.snackbar(
        'Success',
        "Job Apply Successfully",
        backgroundColor:
            Colors.green.shade300, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
      // Navigate to HomePage
      //Get.to(() => Home());

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar(
        'Message',
        r.body,
        backgroundColor: Colors.red, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
    } else {
      Get.snackbar(
        'Error',
        r.body,
        backgroundColor: Colors.red, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
    }

    return r;
  }

  ///6.job save successfully..........post...apis...
  static Future<http.Response> SaveJobAPi(String JobId) async {
    userId = prefs.read("Id").toString();
    print('www:${userId}');
    var url = "${baseUrl}App/AddBookmark";
    var body = jsonEncode({
      "JobId": JobId,
      "userID": userId,
    });

    print("jobsave");
    print(body);

    http.Response r = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );
    print('okapplyjob');
    print(r.body);

    if (r.statusCode == 200) {
      Get.snackbar(
        'Success',
        "Job Saved Successfully",
        backgroundColor:
            Colors.green.shade300, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
      // Navigate to HomePage
      /// Get.to(() => Home());

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar(
        'Message',
        r.body,
        backgroundColor: Colors.red, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
    } else {
      Get.snackbar(
        'Error',
        r.body,
        backgroundColor: Colors.red, // Set the background color to green
        snackPosition: SnackPosition.TOP, // Set the position of the snackbar
        duration: Duration(
            seconds: 2), // Set the duration of the snackbar to 2 seconds
      );
    }

    return r;
  }

  ///api 7.....all  saved jobs....
  static AllSavedJobsApi() async {
    userId = prefs.read("Id").toString();
    print('wwwsaved:${userId}');
    var url = "${baseUrl}App/GetBookmarks?userId=$userId";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var GetJobSavedListModel = allJobsSavedApiFromJson(r.body);
        return GetJobSavedListModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///api 8.....all  saved jobs....
  static AllAppliedJobsApi() async {
    userId = prefs.read("Id").toString();
    print('wwwsaved:${userId}');
    var url = "${baseUrl}App/GetJobapplyList?userId=$userId";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var GetJobAppliedListModel = allJobsAppliedApiFromJson(r.body);
        return GetJobAppliedListModel;
      }
      print(url);
      print(r.body);
      print(r.statusCode);
    } catch (error) {
      return;
    }
  }

  ///api.9. delete  apis.....
  static Future<bool> deleteJobApi(int jobId) async {
    //https://api.hirejobindia.com/api/App/DeleteBookmarkjob/?id=5
    var url = "${baseUrl}App/DeleteBookmarkjob/?id=$jobId";

    final url2 = Uri.parse(url);
    final response = await http.delete(url2);

    print("urldlt111");
    print(url);

    if (response.statusCode == 200) {
      print("urldlt");
      print(url);
      Get.to(Bookmark());

      return true;
    } else {
      return false;
    }
  }

  ///

  ///

  ///registration....
  // static Future<http.Response> createProfile(
  //     Map<String, dynamic> formData) async {
  //   const String apiUrl =
  //       'https://api.hirejobindia.com/api/Login/createProfile';
  //
  //   try {
  //     final http.Response response = await http.post(
  //       Uri.parse(apiUrl),
  //       body: formData,
  //     );
  //     print("data${formData}");
  //
  //     return response;
  //   } catch (error) {
  //     throw Exception('Failed to create profile: $error');
  //   }
  // }

  ///

  static String apiUrl2 = "${baseUrl}Login/createProfile";

  //var url = "${baseUrl}App/DeleteBookmarkjob/?id=$jobId";
  //static const String apiUrl = 'https://api.hirejobindia.com/api/Login/createProfile';
  ///

  // static Future<http.Response> createProfile(Map<String, String> formData,
  //     Uint8List cvFileContent, String cvFileName) async {
  //   var uri = Uri.parse(apiUrl);
  //   var request = http.MultipartRequest('POST', uri);
  //   print("urixzxzx");
  //
  //   print(uri);
  //
  //   // Add form fields
  //   formData.forEach((key, value) {
  //     request.fields[key] = value;
  //   });
  //
  //   // Add file field
  //   request.files.add(http.MultipartFile.fromBytes(
  //     'CVFileName', // The name of the file field
  //     cvFileContent,
  //     filename: cvFileName, // Use the file name from the parameter
  //     contentType:
  //         MediaType('application', 'pdf'), // Use MediaType from http_parser
  //   ));
  //
  //   // Send the request
  //   var response = await request.send();
  //   return http.Response.fromStream(response);
  // }

  ///state api..
  ///state Api get...........................
  static Future<List<StateModelss>> getSatesApi() async {
    var url = "${baseUrl}EmployeeApi/Getstate";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var statesData = stateModelFromJson(r.body);
        return statesData.data;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  ///todo: city by stste id...
  static Future<List<CityModell>> getCitiesApi(String stateID) async {
    var url = "${baseUrl}EmployeeApi/getcity?stateid=$stateID";
    try {
      http.Response r = await http.get(Uri.parse(url));
      print(r.body.toString());
      if (r.statusCode == 200) {
        var citiesData = cityModelFromJson(r.body);
        return citiesData.data;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  ///4.login_employeee..........post...apis...
  static Future<http.Response> EmployeeLoginApi(
      String employee_ID, String password) async {
    var url = "${baseUrl}Login/EmployeeLogin";
    var body = jsonEncode({
      "employee_ID": employee_ID,
      "password": password,
    });

    print("loginnnnemployee");
    print(body);

    http.Response r = await http.post(
      Uri.parse(url),
      body: body,
      headers: {
        "Content-Type": "application/json",
      },
    );

    print(r.body);

    if (r.statusCode == 200) {
      var responseData = json.decode(r.body);
      var employeeId = responseData['loginemp']['id'];
      var token = responseData['token'];
      //token
      // Save employee ID and token
      final storage = GetStorage();
      storage.write("Id", employeeId);
      storage.write("token", token);

      print('Saved employeeId: $employeeId');
      print('Saved token: $token');

      // Save user ID (assuming 'Id' is part of the response JSON)
      prefs.write("Id", employeeId);
      print('Saved employeeId: $employeeId');

      ///token...
      prefs.write("token".toString(), json.decode(r.body)['token']);
      token = prefs.read("token").toString();
      print("tokennnn");
      print(token);
      // Navigate to HomePage
      //Get.to(() => Home());

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('Message', 'Unauthorized: ${r.body}');
    } else {
      Get.snackbar('Error', 'Error: ${r.body}');
    }

    return r;
  }

  ///profile personal_info_employee....5...

  static PriofilePersonalEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}EmployeeApi/GetEmployeePresnolInfo';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        GetProfileEmployeePersonalModel? geetprofilepersonalmodel =
            getProfileEmployeePersonalModelFromJson(r.body);
        print(
            "profileinfo: ${geetprofilepersonalmodel.data!.personalEmailAddress}");
        return geetprofilepersonalmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('profileedetaileror: $error');
    }
  }

  ///profile basic_info_employee....6...

  static PriofileBasicEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}EmployeeApi/GetEmployeeBasicInfo';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        BasicInformationModel? geetprofilepersonalmodel =
            basicInformationModelFromJson(r.body);
        print("profileinfo: ${geetprofilepersonalmodel.data!.employeeId}");
        return geetprofilepersonalmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('profileedetaileror: $error');
    }
  }

  ///profile bank_info_employee....7...

  static PriofileBankDetailEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}EmployeeApi/GetEmployeeBankdetail';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        BankDetailInformationModel? geetprofilbankmodel =
            bankDetailInformationModelFromJson(r.body);
        print("profileinfobnk: ${geetprofilbankmodel.data!.accountHolderName}");
        return geetprofilbankmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('profileedetaileror: $error');
    }
  }

  ///offer_employee_appointment_api...8

  static OfferAppointmentEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}EmployeeApi/GetOfferAndAppointmentLeter';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        GetOfferAppointmentModel? getapptoffermodel =
            getOfferAppointmentModelFromJson(r.body);
        print("profileinfobnk: ${getapptoffermodel.data!.offerletter}");
        return getapptoffermodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('profileedetaileror: $error');
    }
  }

  /// Employee - Get all salary slips
  static Future<AllsalaryslipModells?> getSalarySlips() async {
    String userId = GetStorage().read("userId").toString();
    String token = GetStorage().read("token").toString();
    var url = "${baseUrl}EmployeeApi/GetAllEmpsalaryslip";

    try {
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response response = await http.get(Uri.parse(url), headers: headers);
      print(response.body);

      if (response.statusCode == 200) {
        var allSalarySlipModels = allsalaryslipModellsFromJson(response.body);
        return allSalarySlipModels;
      } else {
        print(
            'Failed to load salary slips. Status code: ${response.statusCode}');
        //Get.snackbar('Error', 'Failed to load salary slips');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      Get.snackbar('Error', 'An error occurred while fetching salary slips');
      return null;
    }
  }

  /// Employee - Get all salary slips
  // static Future<DashbordModel?> getDashboardApi() async {
  //   String? userId = GetStorage().read("userId")?.toString();
  //   String? token = GetStorage().read("token")?.toString();
  //
  //   if (userId == null || token == null) {
  //     Get.snackbar('Error', 'User ID or Token is missing');
  //     return null;
  //   }
  //
  //   var url = "${baseUrl}EmployeeApi/Dashboard";
  //
  //   try {
  //     Map<String, String> headers = {
  //       'Authorization': 'Bearer $token',
  //       'Content-Type': 'application/json'
  //     };
  //
  //     http.Response response = await http.get(Uri.parse(url), headers: headers);
  //
  //     print("Response status: ${response.statusCode}");
  //     print("Response body: ${response.body}");
  //
  //     print("Responseurl: ${url}");
  //
  //     if (response.statusCode == 200) {
  //       var allDashboardModels = dashbordModelFromJson(response.body);
  //       return allDashboardModels;
  //     } else if (response.statusCode == 401) {
  //       Get.snackbar('Message', 'Unauthorized: ${response.body}');
  //       // Clear token and navigate to login page
  //       //GetStorage().remove('userId');
  //       //GetStorage().remove('token');
  //       //Get.offAll(() => Login());
  //       return null;
  //     } else {
  //       Get.snackbar('Error',
  //           'Failed to load Dashboard. Status code: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (error) {
  //     Get.snackbar(
  //         'Error', 'An error occurred while fetching the dashboard: $error');
  //     return null;
  //   }
  // }

  static getDashboardApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}EmployeeApi/Dashboard';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url), headers: headers);
      if (r.statusCode == 200) {
        print("url");
        print(url);
        DashbordModel? geetdashbord = dashbordModelFromJson(r.body);
        print("profileinfobnk: ${geetdashbord.data?.completionPercentage!}");
        return geetdashbord;
      } else {
        print('Failed to load dashboard');
      }
    } catch (error) {
      print('profileedetaileror: $error');
    }
  }

  ///support comman for both.....

  static SupportUserEmployeeApi() async {
    var prefs = GetStorage();

    // Read saved user id and token
    userId = prefs.read("Id").toString();
    print('wwwuseridEE: $userId');

    token = prefs.read("token").toString();
    print('token: $token');
    var url = '${baseUrl}App/ContactDetail';
    try {
      // Add the token to the headers
      Map<String, String> headers = {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json'
      };

      http.Response r = await http.get(Uri.parse(url));
      if (r.statusCode == 200) {
        print("url");
        print(url);
        //SupportModel supportModelFromJson
        SupportModel? getsupportmodel = supportModelFromJson(r.body);
        print("profileinfobnk: ${getsupportmodel.response!.id}");
        return getsupportmodel;
      } else {
        print('Failed to load profile information');
      }
    } catch (error) {
      print('profileedetaileror: $error');
    }
  }

  ///
}

///todo: device  user token for user........
//  //login with plus cart api gyros api 19.....................................
//
//   static cartplusApi(
//     var productId,
//   ) async {
//     var url = baseUrl + 'api/ProductApi/PlusAddToCart/$productId';
//     var prefs = GetStorage();
//     //saved id..........
//
//     final userId = prefs.read("Id").toString();
//     print('&&&&&&&&&&&&&&&&&&&&&&okoko:${userId}');
//
//     token = prefs.read("token").toString();
//     print('&&&&&&&&&&&&&&&&&&&&&&okok:${token}');
//     var body = {
//       "Id": userId,
//     };
//     final headers = {"Authorization": "Bearer $token"};
//
//     print(body);
//     http.Response r =
//         await http.post(Uri.parse(url), body: body, headers: headers);
//     print(r.body);
//     print(r.statusCode);
//
//     if (r.statusCode == 200) {
//       return r;
//     } else {
//       Get.snackbar('Error', 'not increase');
//       return r;
//     }
//   }
//
//   //login with decrease cart api gyros api 20..................................
//
//   static cartminusApi(
//     var productId,
//   ) async {
//     var url = baseUrl + 'api/ProductApi/DeleteAddToCart/$productId';
//
//     var prefs = GetStorage();
//     //saved id..........
//
//     final userId = prefs.read("Id").toString();
//     print('&&&&&&&&&&&&&&&&&&&&&&okoko:${userId}');
//
//     token = prefs.read("token").toString();
//     print('&&&&&&&&&&&&&&&&&&&&&&okok:${token}');
//     var body = {
//       "Id": userId,
//     };
//     final headers = {"Authorization": "Bearer $token"};
//
//     print(body);
//     http.Response r =
//         await http.post(Uri.parse(url), body: body, headers: headers);
//     print(r.body);
//     print(r.statusCode);
//
//     if (r.statusCode == 200) {
//       var data = jsonDecode(r.body.toString());
//       if (r.statusCode == 200) {
//         Get.snackbar('message', "success");
//       } else {
//         Get.snackbar('message', data["error"]);
//       }
//       return r;
//     } else {
//       // Get.snackbar('message', data["stat"]);
//       return r;
//     }
//   }
//
//   //sub_address_by_id  gyros api 21.....................................

///.....
//  //login with email api gyros api 2..................................
//
//   static LoginEmailApi(
//     var Email,
//     var PassWord,
//   ) async {
//     var url = baseUrl + 'api/AdminApi/LoginWithEmail';
//
//     var body = {
//       "Email": Email,
//       "PassWord": PassWord,
//     };
//     print(body);
//     http.Response r = await http.post(
//       Uri.parse(url), body: body,
//       //headers: headers
//     );
//     print(r.body);
//     if (r.statusCode == 200) {
//       var prefs = GetStorage();
//       //saved id..........
//       prefs.write("Id".toString(), json.decode(r.body)['Id']);
//       Id = prefs.read("Id").toString();
//       print('&&&&&&&&&&&&&&&&&&&&&&:${Id}');
//
//       //saved token.........
//       prefs.write("token".toString(), json.decode(r.body)['token']);
//       token = prefs.read("token").toString();
//       print(token);
//       return r;
//     } else if (r.statusCode == 401) {
//       Get.snackbar('message', r.body);
//     } else {
//       Get.snackbar('Error', r.body);
//       return r;
//     }
//   }

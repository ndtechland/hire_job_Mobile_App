import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
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
  static String Token = '';

  //static String catid = '';
  //static String productid = '';
  //static String orderid = '';
  static String Id = '';
  static String MedicineId = ''.toString();
  static String adminId = ''.toString();
  static String userid = ''.toString();

  final box = GetStorage();

  ///TODO: here we have to add different api in this page...........
  /// TODO: from here user 1 section...........
  ///
  //user signup..............

  //login user api ps welness api 1..................................

  static UserSignUpApi(
    var PatientName,
    var EmailId,
    var MobileNumber,
    var Password,
    var State,
    var City,
    var Address,
    var Pincode,
  ) async {
    //var a= int.parse(State).toString();
    //var b= int.parse(City).toString();
    var url = '${baseUrl}api/PatientApi/PatientRegistration';
    var body = {
      "PatientName": PatientName,
      "EmailId": EmailId,
      "MobileNumber": MobileNumber,
      "Password": Password,
      "State": State,
      "City": City,
      "Address": Address,
      "Pincode": Pincode,
    };

    // print(body);

    http.Response r = await http.post(
      Uri.parse(url), body: body,
      //headers: headers
    );
    // print(r.body);
    if (r.statusCode == 200) {
      print(r.body);

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('message', r.body);
    } else {
      Get.snackbar('Error', r.body);
      return r;
    }
  }

  ///here signup api of user.............24 april 2023...

  static UserSignUpApinew(
    var PatientName,
    var EmailId,
    var MobileNumber,
    var Password,
    var ConfirmPassword,
    var StateMasterId,
    var CityMasterId,
    var Location,
    var Pincode,
    var DOB,
    var Gender,
  ) async {
    var url = '${baseUrl}api/SignupApi/PatientRegistration';
    var body = {
      "PatientName": PatientName,
      "EmailId": EmailId,
      "MobileNumber": MobileNumber,
      "Password": Password,
      "ConfirmPassword": ConfirmPassword,
      "StateMaster_Id": StateMasterId,
      "CityMaster_Id": CityMasterId,
      "Location": Location,
      "Pincode": Pincode,
      "DOB": "$DOB",
      "Gender": "$Gender"
    };
    http.Response r = await http.post(
      Uri.parse(url), body: body,
      //headers: headers
    );
    // print(r.body);
    if (r.statusCode == 200) {
      Get.snackbar(
        'Success',
        r.body,
        duration: const Duration(seconds: 2),
      );
      print(r.body);

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar(
        'message',
        r.body,
        duration: const Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Error',
        r.body,
        duration: const Duration(seconds: 2),
      );
      return r;
    }
  }

  ///here delivery address api of user.............27 april 2023...

  static deliverymedicineAddressApi(
    var Name,
    var Email,
    //var Password,
    var MobileNumber,
    var StateMasterId,
    var CityMasterId,
    var DeliveryAddress,
    var PinCode,
    //var Patient_Id,
  ) async {
    var url = '${baseUrl}api/PatientApi/MedicineAddress';
    //saved id..........
    var prefs = GetStorage();
    //prefs.write("Id".toString(), json.decode(r.body)['data']['Id']);
    userid = prefs.read("Id").toString();
    print('&&&&&&&&&&&&&&&&&&&&&&userid:${Id}');
    var body = {
      "Name": Name,
      "Email": Email,
      //"Password": "12345",
      "MobileNumber": MobileNumber,
      "StateMaster_Id": StateMasterId,
      "CityMaster_Id": CityMasterId,
      "DeliveryAddress": DeliveryAddress,
      "PinCode": PinCode,
      "Patient_Id": userid,
    };
    http.Response r = await http.post(
      Uri.parse(url), body: body,
      //headers: headers
    );
    // print(r.body);
    if (r.statusCode == 200) {
      print(r.body);
      print(body);

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('message', r.body);
    } else {
      Get.snackbar('Error', r.body);
      return r;
    }
  }

  ///todo:here lab booking1 api of user.............27 april 2023...

  static labbookingpostApi(
    var StateMasterId,
    var CityMasterId,
    var testId,
  ) async {
    var url = '${baseUrl}api/LabApi/LabBooking';
    var body = {
      "StateMaster_Id": StateMasterId,
      "CityMaster_Id": CityMasterId,
      "testId": testId,
    };
    http.Response r = await http.post(
      Uri.parse(url), body: body,
      //headers: headers
    );
    // print(r.body);
    if (r.statusCode == 200) {
      print(r.body);
      print(body);

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('message', r.body);
    } else {
      Get.snackbar('Error', r.body);
      return r;
    }
  }

  ///todo:here doctor booking1 api of user.............1 may 2023...

  static doctorbooking1postApi(
    var Department_id,
    var Specialist_id,
    var StateMaster_Id,
    var CityMaster_Id,
  ) async {
    var url = '${baseUrl}api/DoctorApi/DoctorChoose';
    var body = {
      "Department_id": Department_id,
      "Specialist_id": Specialist_id,
      "StateMaster_Id": StateMaster_Id,
      "CityMaster_Id": CityMaster_Id,
    };
    http.Response r = await http.post(
      Uri.parse(url), body: body,
      //headers: headers
    );
    // print(r.body);
    if (r.statusCode == 200) {
      print(r.body);
      print(body);

      return r;
    } else if (r.statusCode == 401) {
      Get.snackbar('message', r.body);
    } else {
      Get.snackbar('Error', r.body);
      return r;
    }
  }

  ///todo:here doctor apt done api of user.............4_oct.... 2023...

  ///login user api ps welness api 2..................................
  static LoginEmailApi(
    var Username,
    var Password,
  ) async {
    var url = '${baseUrl}api/SignupApi/Login';

    var body = {
      "Username": Username,
      "Password": Password,
    };
    print(body);
    http.Response r = await http.post(
      Uri.parse(url), body: body,
      //headers: headers
    );
    print(r.body);
    if (r.statusCode == 200) {
      //CallLoader.loader();
      await Future.delayed(Duration(milliseconds: 500));
      //CallLoader.hideLoader();
      var prefs = GetStorage();

      ///here we are defining status code.....
      var status = json.decode(r.body)['Status'];
      print('ywgefYKUWEFG${status}');
      if (status == 0) {
        Get.snackbar('Failed', '${json.decode(r.body)['Message']}',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: (Duration(seconds: 3)));
        //CallLoader.hideLoader();
      } else {
        //await _getGeoLocationPosition();
        //CallLoader.hideLoader();
        // CallLoader.loader();
        //CallLoader.loader();
        await Future.delayed(Duration(seconds: 2));
        Get.snackbar('Sucess', '${json.decode(r.body)['Message']}',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green.shade400,
            colorText: Colors.white,
            duration: (Duration(seconds: 3)));

        print('princee notificationdsfvdsvdsv');
      }

      //saved id..........
      prefs.write("Id".toString(), json.decode(r.body)['data']['Id']);
      Id = prefs.read("Id").toString();
      print('&&&&&&&&&&&&&&&&&&&&&&user:${Id}');

      //saved id..........
      prefs.write("Id".toString(), json.decode(r.body)['data']['Id']);
      userid = prefs.read("Id").toString();
      print('&&&&&&&&&&&&&&&&&&&&&&userid:${Id}');
      //  static String DoctorId = ''.toString();

      prefs.write(
          "DoctorId".toString(), json.decode(r.body)['data']['DoctorId']);
      //DoctorId = prefs.read("DoctorId").toString();

      //saved user credentials..........
      prefs.write("PatientRegNo".toString(),
          json.decode(r.body)['data']['PatientRegNo']);
      //PatientRegNo = prefs.read("PatientRegNo").toString();
//user password........
      prefs.write(
          "Password".toString(), json.decode(r.body)['data']['Password']);
      //userPassword = prefs.read("Password").toString();
//
      //device driverpassword

      prefs.write(
          "Password".toString(), json.decode(r.body)['data']['Password']);
      // driverpassword = prefs.read("Password").toString();
      //device driverId........
      prefs.write(
          "DriverId".toString(), json.decode(r.body)['data']['DriverId']);
      // DriverId = prefs.read("DriverId").toString();

      //device driverId........
      prefs.write(
          "DriverId".toString(), json.decode(r.body)['data']['DriverId']);
      // DriverId = prefs.read("DriverId").toString();

      //device nurseId........
      prefs.write("NurseId".toString(), json.decode(r.body)['data']['NurseId']);

      ///NurseId = prefs.read("NurseId").toString();
//adminId
      //StatemasterId = ''.toString();
      //   static String CitymasterId
      ///todo: save state id........
      prefs.write("StateMaster_Id".toString(),
          json.decode(r.body)['data']['StateMaster_Id']);
      //StatemasterId = prefs.read("StateMaster_Id").toString();
      // print('&&&&statemasterId:${StatemasterId}');

      ///todo: save city id........
      prefs.write("CityMaster_Id".toString(),
          json.decode(r.body)['data']['CityMaster_Id']);
      //CitymasterId = prefs.read("CityMaster_Id").toString();
      /// print('&&citymasterId:${CitymasterId}');

      ///var prefs = GetStorage();
      //savid..........
      prefs.write("AdminLogin_Id".toString(),
          json.decode(r.body)['data']['AdminLogin_Id']);
      adminId = prefs.read("AdminLogin_Id").toString();
      print('&&&&&&&&&&&&&&&&&&&&&&:${adminId}');

      ///
      return r;
    } else if (r.statusCode == 401) {
      await Future.delayed(Duration(seconds: 3));
      Get.snackbar('Error', r.body);
      return r;
      //Get.snackbar('message', r.body);
    } else {
      // CallLoader.loader();
      await Future.delayed(Duration(seconds: 2));
      Get.snackbar("Failed", "${r.body}");
      //CallLoader.hideLoader();
      // Get.snackbar('Error', r.body);
      return r;
    }
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

  ///5.profile_api...
  static PriofileApi() async {
    var prefs = GetStorage();

    //saved userid..........
    //prefs.write("Id".toString(), json.decode(r.body)['Id']);
    userid = prefs.read("Id").toString();
    print('wwwuseridEE:${userid}');
    //https://api.hirejobindia.com/api/App/GetProfile?userId=2
    var url = '${baseUrl}App/GetProfile?userId=$userid';
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
    userid = prefs.read("Id").toString();
    print('www:${userid}');
    var url = "${baseUrl}App/Applyjob";
    var body = jsonEncode({
      "JobId": JobId,
      "userID": userid,
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
    userid = prefs.read("Id").toString();
    print('www:${userid}');
    var url = "${baseUrl}App/AddBookmark";
    var body = jsonEncode({
      "JobId": JobId,
      "userID": userid,
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
    userid = prefs.read("Id").toString();
    print('wwwsaved:${userid}');
    var url = "${baseUrl}App/GetBookmarks?userId=$userid";
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
    userid = prefs.read("Id").toString();
    print('wwwsaved:${userid}');
    var url = "${baseUrl}App/GetJobapplyList?userId=$userid";
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
  static const String apiUrl =
      'https://api.hirejobindia.com/api/Login/createProfile';

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
    return http.Response.fromStream(response);
  }

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

  ///
}

///todo: device  user token for user........

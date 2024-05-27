import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hirejobindia/models/all_catagary.dart';
import 'package:http/http.dart' as http;

import '../constants/static_text.dart';
import '../models/all_jobs_model.dart';
import '../models/company_model.dart';
import '../models/testimonial_model.dart';

var prefs = GetStorage();

class ApiProvider {
  /// static var baseUrl = 'http://test.pswellness.in/';

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
  ///

  // static Future<Testimonial?> AlltestimonialApi() async {
  //   var url = "${baseUrl}Admin/getAllTestimonial";
  //   try {
  //     http.Response response = await http.get(Uri.parse(url));
  //     print(response.body);
  //     if (response.statusCode == 200) {
  //       return Testimonial.fromJson(jsonDecode(response.body));
  //     } else {
  //       print('Request failed with status: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (error) {
  //     print('Error fetching testimonial: $error');
  //     return null;
  //   }
  // }

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

  // var url = "${baseUrl}Admin/FilterData";
  // Future<Map<String, dynamic>> AllcatagoryApi() async {
  //   try {
  //     final response = await http.get(Uri.parse(url));
  //     if (response.statusCode == 200) {
  //       return json.decode(response.body);
  //     } else {
  //       throw Exception('Failed to load categories: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching categories: $e');
  //     throw Exception('Failed to load categories: $e');
  //   }
  // }

  ///todo: device  user token for user........
}

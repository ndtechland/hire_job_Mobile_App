import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/emploree_pages/profile_employee/profile_employee.dart';
import 'package:hirejobindia/modules/all_pages/pages/emploree_pages/salary_slip_view.dart';
import 'package:hirejobindia/modules/all_pages/pages/login.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../components/responsive_text.dart';
import '../../../../constants/static_text.dart';
import '../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';
import '../../../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../../../controllers/employeee_controllersss/employee_offer_appointment/offer_apt_employee_controller.dart';
import '../../../../controllers/employeee_controllersss/salary_slip_controller/salary_slip_controllerss.dart';
import '../view_pdf_only.dart';

class EmployeeNavBar extends StatelessWidget {
  EmployeeNavBar({Key? key}) : super(key: key);

  AptOfferEmployeeController _aptOfferEmployeeController =
      Get.put(AptOfferEmployeeController());

  ProfileEmployeeController _profileEmployeeController =
      Get.put(ProfileEmployeeController());

  EmployeeLoginController _employeeloginController =
      Get.put(EmployeeLoginController());

  AllSalarySlipController _allsalaryslipController =
      Get.put(AllSalarySlipController());

  //AllSavedJobController _savedJobController = Get.put(AllSavedJobController());
  // AllAppliedJobController _allappliedController =
  //Get.put(AllAppliedJobController());
  // HomePageController _homePageController = Get.find();
  //final RegistrationController _registrationController =
  //Get.put(RegistrationController());

  final snackBarDuration = Duration(seconds: 3); // Define your desired duration

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[logoColor, logoColor]),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: responsiveContainer(
                          // padding: const EdgeInsets.only(right: 0),
                          //height: 20,
                          //width: 20,
                          heightPortrait:
                              MediaQuery.of(context).size.height * 0.12,
                          widthPortrait:
                              MediaQuery.of(context).size.width * 0.25,
                          heightLandscape:
                              MediaQuery.of(context).size.height * 0.3,
                          widthLandscape:
                              MediaQuery.of(context).size.width * 0.2,
                          // height: MediaQuery.of(context).size.height *
                          //     0.05, // 20% of screen height if not provided
                          // width: MediaQuery.of(context).size.width * 0.09,
                          //                                    "${_getprofileepersonal.getprofileemployeeModel?.data?.personalEmailAddress}",
                          child: _profileEmployeeController
                                      .getprofileemployeeModel
                                      ?.data
                                      ?.profileImage !=
                                  null
                              ? Image.network(
                                  "${FixedText.apiurl2}${_profileEmployeeController.getprofileemployeeModel?.data?.profileImage}",
                                  //color: appColor,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      'lib/assets/logo/hirelogo11.png',
                                      fit: BoxFit.fill,
                                    );
                                  },
                                )
                              : Image.network(
                                  'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                                  fit: BoxFit.fill,
                                ),
                          context: context,
                        ),
                      ),
                    ),
                    responsiveText(
                      context: context,
                      text:
                          ("${_profileEmployeeController.getprofileemployeeModel?.data?.name?.toString()}"),
                      fontSizePortrait: 14,
                      fontSizeLandscape: 19,
                      color: Colors.white,
                    ),
                    // Text(
                    //   "${_profileEmployeeController.getprofileemployeeModel?.data?.name?.toString()}",
                    //   style: TextStyle(
                    //       fontSize: 18,
                    //       fontFamily: 'medium',
                    //       color: Colors.white),
                    // ),
                    responsiveText(
                      context: context,
                      text:
                          ("${_profileEmployeeController.getprofileemployeeModel?.data?.personalEmailAddress.toString()}"),
                      fontSizePortrait: 11,
                      fontSizeLandscape: 19,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
            // UserAccountsDrawerHeader(
            //   accountName: const Text(
            //     'Kumar Prince',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   accountEmail: const Text(
            //     'prince@prince.com',
            //     style: TextStyle(color: Colors.white),
            //   ),
            //   currentAccountPicture: CircleAvatar(
            //     child: ClipOval(
            //       child: Image.asset(
            //         'lib/assets/images/s3.jpg',
            //         fit: BoxFit.cover,
            //         width: 90,
            //         height: 90,
            //       ),
            //     ),
            //   ),
            // ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('View Profile'),
              onTap: () async {
                _profileEmployeeController.profileemployeeApi();
                _profileEmployeeController.profileBasicemployeeApi();
                _profileEmployeeController.profileEmployeBankApi();

                //profileBasicemployeeApi();
                //     profileEmployeBankApi();

                _profileEmployeeController.update();
                // await _profileController.profileApi();
                // _profileController.update();
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EmployeeProfile()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.save_alt_sharp),
              title: const Text('Salary Slip'),
              onTap: () async {
                await _allsalaryslipController.fetchSalarySlips();
                _allsalaryslipController.onInit();
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllSalarySlip()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.done_all),
              title: const Text('Apply For Leaves'),
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Company()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.stay_current_landscape_rounded),
              title: const Text('Offer latter '),
              onTap: () async {
                await _aptOfferEmployeeController.ampofferemployeeApi();
                _aptOfferEmployeeController.update();

                // Get the URL of the PDF file from the profile information
                String url =
                    "${FixedText.offaptpdfurl}${_aptOfferEmployeeController.getampofferModel?.data?.offerletter?.toString()}";
                print("url");
                print(url);
                // final String? url =
                //     "https://admin.hirejobindia.com//OfferLetter/6905205d-23cf-46a7-bc12-d708f46ad51120240413162904075.pdf";
                //

                if (url != null) {
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // Prevent dismissing dialog by tapping outside
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(), // Circular loader
                            SizedBox(height: 10),
                            Text(
                                'Loading Offer Latter....'), // Text indicating download process
                          ],
                        ),
                      );
                    },
                  );

                  try {
                    // Load the PDF file from the network
                    final file = await loadPdfFromNetwork(url);
                    Navigator.pop(context); // Close the loading dialog

                    if (file != null) {
                      // Open the PDF viewer page
                      openPdf(context, file, url);
                    } else {
                      // Handle error if file loading failed
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text('Failed to load PDF file.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  } catch (e) {
                    print('Error downloading PDF: $e');
                    Navigator.pop(context); // Close the loading dialog
                    // Handle error if downloading fails
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Failed to download PDF file.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  // Handle error if URL is null
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('URL is null.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  Get.back();
                }

                //Get.back();

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Company()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Appointment Latter '),
              onTap: () async {
                await _aptOfferEmployeeController.ampofferemployeeApi();
                _aptOfferEmployeeController.update();

                // Get the URL of the PDF file from the profile information
                String url =
                    "${FixedText.offaptpdfurl}${_aptOfferEmployeeController.getampofferModel?.data?.appointmentletter?.toString()}";
                print("url");
                print(url);
                // final String? url =
                //     "https://admin.hirejobindia.com//OfferLetter/6905205d-23cf-46a7-bc12-d708f46ad51120240413162904075.pdf";
                //

                if (url != null) {
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // Prevent dismissing dialog by tapping outside
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(), // Circular loader
                            SizedBox(height: 10),
                            Text(
                                'Loading Apt latter....'), // Text indicating download process
                          ],
                        ),
                      );
                    },
                  );

                  try {
                    // Load the PDF file from the network
                    final file = await loadPdfFromNetwork(url);
                    Navigator.pop(context); // Close the loading dialog

                    if (file != null) {
                      // Open the PDF viewer page
                      openPdf(context, file, url);
                    } else {
                      // Handle error if file loading failed
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Error'),
                          content: Text('Failed to load PDF file.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  } catch (e) {
                    print('Error downloading PDF: $e');
                    Navigator.pop(context); // Close the loading dialog
                    // Handle error if downloading fails
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text('Failed to download PDF file.'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                } else {
                  // Handle error if URL is null
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Error'),
                      content: Text('URL is null.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('OK'),
                        ),
                      ],
                    ),
                  );
                  Get.back();
                }

                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Company()));
              },
            ),

            ///todo: inbox and chat features.....
            // ListTile(
            //   leading: const Icon(Icons.inbox),
            //   title: const Text('Inbox'),
            //   onTap: () {
            //     // Navigator.push(context,
            //     //     MaterialPageRoute(builder: (context) => const Inbox()));
            //   },
            // ),
            ///todo: end inbox and chat features.....

            // ListTile(
            //   leading: const Icon(Icons.inventory_outlined),
            //   title: const Text('Invite Friend'),
            //   onTap: () async {
            //     // _registrationController.getStatepi();
            //     // _registrationController.onInit();
            //     // _registrationController.selectedState.value = null;
            //     // await Future.delayed(Duration(milliseconds: 800));
            //     //
            //     // await Navigator.push(
            //     //     context,
            //     //     MaterialPageRoute(builder: (context) => RegistrationPage()
            //     //       //InviteFriend()
            //     //     ));
            //   },
            // ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () async {
                // Show loading dialog
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );

                _employeeloginController.onInit();

                await Future.delayed(Duration(seconds: 1));

                await SharedPreferences.getInstance()
                    .then((prefs) => prefs.clear());

                // Hide loading dialog
                Get.back();

                // Navigate to login screen
                await Get.offAll(() => Login());

                // Show success snackbar
                // Get.snackbar(
                //   'Success',
                //   'Successfully logged out',
                //   snackPosition: SnackPosition.TOP,
                //   backgroundColor: Colors.green,
                //   duration: snackBarDuration, // Set the duration
                // );
              },
            ),
          ],
        ),
      ),
    );
  }

  ///pdf:downlload...
  Future<File?> pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) return null;
    return File(result.paths.first ?? '');
  }

  Future<File> loadPdfFromNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    if (kDebugMode) {
      print('$file');
    }
    return file;
  }

  //final file = File('example.pdf');
  //await file.writeAsBytes(await pdf.save());

  void openPdf(BuildContext context, File file, String url) =>
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PdfViewerPage(
            file: file,
            url: url,
          ),
        ),
      );
}

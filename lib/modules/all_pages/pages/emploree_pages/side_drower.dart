import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/emploree_pages/profile_employee/profile_employee.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../components/responsive_text.dart';
import '../../../../controllers/employee_controller/profile_controller/profile_info_employee_controller.dart';

class EmployeeNavBar extends StatelessWidget {
  EmployeeNavBar({Key? key}) : super(key: key);

  ProfileEmployeeController _profileEmployeeController =
      Get.put(ProfileEmployeeController());

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
                    colors: <Color>[appColor2, appColor]),
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
                          child:
                              // _profileController.getprofileModel?.response!
                              //     .profileImage !=
                              //     null
                              //     ? Image.network(
                              //   "${_profileController.getprofileModel?.response!.profileImage.toString()}",
                              //   //color: appColor,
                              //   fit: BoxFit.cover,
                              //   errorBuilder: (context, error, stackTrace) {
                              //     return Image.asset(
                              //       'lib/assets/logo/hirelogo11.png',
                              //       fit: BoxFit.fill,
                              //     );
                              //   },
                              // )
                              //     :
                              Image.network(
                            'https://ih1.redbubble.net/image.5098928927.2456/flat,750x,075,f-pad,750x1000,f8f8f8.u2.jpg',
                            fit: BoxFit.fill,
                          ),
                          context: context,
                        ),
                      ),
                    ),
                    Text(
                      "prince",
                      //"${_profileController.getprofileModel?.response?.fullName.toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "email@gmail.com",
                      //"${_profileController.getprofileModel?.response?.emailId.toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
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
                await _profileEmployeeController.profileemployeeApi();
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
                // await _allappliedController.appliedjobListApi();
                // _allappliedController.onInit();
                // await Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => AppliedJobs()));
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
              onTap: () {
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => Company()));
              },
            ),

            ListTile(
              leading: const Icon(Icons.picture_as_pdf),
              title: const Text('Appointment Latter '),
              onTap: () {
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

            ListTile(
              leading: const Icon(Icons.inventory_outlined),
              title: const Text('Invite Friend'),
              onTap: () async {
                // _registrationController.getStatepi();
                // _registrationController.onInit();
                // _registrationController.selectedState.value = null;
                // await Future.delayed(Duration(milliseconds: 800));
                //
                // await Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) => RegistrationPage()
                //       //InviteFriend()
                //     ));
              },
            ),
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

                //_loginController.onInit();

                await Future.delayed(Duration(seconds: 1));

                await SharedPreferences.getInstance()
                    .then((prefs) => prefs.clear());

                // Hide loading dialog
                Get.back();

                // Navigate to login screen
                // await Get.offAll(() => Login());

                // Show success snackbar
                Get.snackbar(
                  'Success',
                  'Successfully logged out',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: Colors.green,
                  duration: snackBarDuration, // Set the duration
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

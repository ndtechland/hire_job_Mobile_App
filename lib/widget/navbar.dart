import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/applied_jobs.dart';
import 'package:hirejobindia/modules/all_pages/pages/bookmark.dart';
import 'package:hirejobindia/modules/all_pages/pages/categories.dart';
import 'package:hirejobindia/modules/all_pages/pages/company.dart';
import 'package:hirejobindia/modules/all_pages/pages/invite_friend.dart';
import 'package:hirejobindia/modules/all_pages/pages/notification.dart';
import 'package:hirejobindia/modules/all_pages/pages/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/login_controllers/login_controllersss.dart';
import '../controllers/user_profile_controller/user_profile_controller.dart';
import '../modules/all_pages/pages/login.dart';

class NavBar extends StatelessWidget {
  NavBar({Key? key}) : super(key: key);
  LoginController _loginController = Get.put(LoginController());
  final ProfileController _profileController = Get.find();

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
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Image.asset('lib/assets/images/s3.jpg'),
                        ),
                      ),
                    ),
                    Text(
                      "${_profileController.getprofileModel?.response?.fullName.toString()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "${_profileController.getprofileModel?.response?.emailId.toString()}",
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
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Profile()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Categories'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Categories()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark),
              title: const Text('Bookmark'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Bookmark()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.done_all),
              title: const Text('Applied Jobs'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AppliedJobs()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.computer),
              title: const Text('Companies'),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Company()));
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
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const InviteFriend()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NotificationScreen()));
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

                _loginController.onInit();

                await Future.delayed(Duration(seconds: 1));

                await SharedPreferences.getInstance()
                    .then((prefs) => prefs.clear());

                // Hide loading dialog
                Get.back();

                // Navigate to login screen
                await Get.offAll(() => Login());

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

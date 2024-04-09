import 'package:flutter/material.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/applied_jobs.dart';
import 'package:hirejobindia/modules/all_pages/pages/bookmark.dart';
import 'package:hirejobindia/modules/all_pages/pages/categories.dart';
import 'package:hirejobindia/modules/all_pages/pages/company.dart';
import 'package:hirejobindia/modules/all_pages/pages/profile.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

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
                    const Text(
                      'Kumar Prince',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'prince@gmail.com',
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const Categories()));
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
                    MaterialPageRoute(builder: (context) => const Company()));
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
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const InviteFriend()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.notifications),
              title: const Text('Notification'),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const NotificationScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Log Out'),
              onTap: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) => const NotificationScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}

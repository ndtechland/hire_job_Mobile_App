import 'package:flutter/material.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/modules/all_pages/pages/login.dart';
import 'package:hirejobindia/widget/elevated_button.dart';

class ChangePassword extends StatefulWidget {
  static const String id = 'ChangePassword';

  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(200),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: _buildHeader(),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SingleChildScrollView(
        child: _buildLoginDetail(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            appColor,
            appColor2,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logoImg(),
            const Text(
              'Change Password',
              style: TextStyle(
                  color: Colors.white, fontSize: 26, fontFamily: 'medium'),
            ),
          ],
        ));
  }

  Widget _buildLoginDetail() {
    return Center(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
              )
            ]),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  textField('Password', Icons.mail_outline),
                  textField('Confirm Password', Icons.mail_outline),
                  const SizedBox(height: 20),
                ],
              ),
            ),
            MyElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Login()));
                },
                text: const Icon(Icons.arrow_forward),
                height: 40,
                width: 40),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  logoImg() {
    return Image.asset(
      'lib/assets/logo/hirelogo11.png',
      // 'lib/assets/images/job.png',
      //color: Colors.white,
      width: 120,
      height: 100,
    );
  }
}

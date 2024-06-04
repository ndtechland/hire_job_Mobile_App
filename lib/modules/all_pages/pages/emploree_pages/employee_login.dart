import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:hirejobindia/widget/text_btn.dart';

import '../../../../controllers/employeee_controllersss/employee_login_controllers/employee_login_controllers.dart';
import '../../../../widget/employee_elevatedbutton.dart';

class EmployeeLogin extends StatelessWidget {
  static const String id = 'Login';
  EmployeeLogin({Key? key}) : super(key: key);

  EmployeeLoginController _employeeloginController =
      Get.put(EmployeeLoginController());
  // final RegistrationController _registrationController =
  //     Get.put(RegistrationController());
  ///
  //EmployeeLoginController
  //ProfileController _profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Scaffold(
              backgroundColor: Colors.white,
              body: Obx(
                () => _employeeloginController.isLoading.value
                    ? Center(child: CircularProgressIndicator())
                    //child:
                    : Form(
                        key: _employeeloginController.loginFormKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: SingleChildScrollView(
                          child: Center(
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 20.0,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 24, vertical: 4),
                                    child: Column(
                                      children: [
                                        textField2(
                                          hint: 'Employee ID',
                                          suffixIcon: Icons.person_outline,
                                          controller: _employeeloginController
                                              .usernameController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter Employee ID';
                                            }
                                            return null;
                                          },
                                          // prefixIcon: Icons.person, // Optional
                                        ),
                                        textField2(
                                          hint: 'Password',
                                          suffixIcon: Icons.lock,
                                          controller: _employeeloginController
                                              .passwordController,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Please enter Your Password';
                                            }
                                            return null;
                                          },
                                          //prefixIcon: Icons.lock, // Optional
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            MyTextButton(
                                              onPressed: () {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //     builder: (context) =>
                                                //         const ForgotPassword(),
                                                //   ),
                                                // );
                                              },
                                              text: 'Forgot Password',
                                              colors: appColor,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 24),
                                      ],
                                    ),
                                  ),
                                  MyElevatedButtonemployee(
                                    onPressed: () {
                                      if (_employeeloginController
                                              .loginFormKey.currentState
                                              ?.validate() ??
                                          false) {
                                        _employeeloginController
                                            .checkemployeeLogin();

                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => Home(),
                                        //   ),
                                        // );
                                      }
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(
                                      //     builder: (context) => Home(),
                                      //   ),
                                      // );
                                    },
                                    text: const Icon(Icons.arrow_forward),
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(height: 34),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
              appBar: PreferredSize(
                preferredSize: const Size.fromHeight(200),
                child: AppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          appColor,
                          appColor,
                        ],
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        logoImg(),
                        const Text(
                          'Employee Login!',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontFamily: 'medium',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // PreferredSizeWidget _buildAppBar() {
  //   return PreferredSize(
  //     preferredSize: const Size.fromHeight(200),
  //     child: AppBar(
  //       automaticallyImplyLeading: false,
  //       backgroundColor: Colors.transparent,
  //       flexibleSpace: _buildHeader(),
  //     ),
  //   );
  // }
  ///

  // Widget _buildBody() {
  //   return Center(
  //     child: SingleChildScrollView(child: _buildLoginDetail()),
  //   );
  // }
  ///

  // Widget _buildHeader() {
  //   return Container(
  //       width: double.infinity,
  //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
  //       decoration: const BoxDecoration(
  //           gradient: LinearGradient(
  //         begin: Alignment.topCenter,
  //         end: Alignment.bottomCenter,
  //         colors: [
  //           appColor,
  //           appColor2,
  //         ],
  //       )),
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           logoImg(),
  //           const Text(
  //             'Welcome Back!',
  //             style: TextStyle(
  //                 color: Colors.white, fontSize: 26, fontFamily: 'medium'),
  //           ),
  //         ],
  //       ));
  // }
  ///

  // Widget _buildLoginDetail() {
  //   return Center(
  //     child: Container(
  //       width: double.infinity,
  //       margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(20),
  //           boxShadow: const [
  //             BoxShadow(
  //               color: Colors.black12,
  //               blurRadius: 20.0,
  //             )
  //           ]),
  //       child: Column(
  //         children: [
  //           Container(
  //             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
  //             child: Column(
  //               children: [
  //                 textField('Username', Icons.person_outline),
  //                 textField('Password', Icons.remove_red_eye),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.end,
  //                   children: [
  //                     MyTextButton(
  //                         onPressed: () {
  //                           Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (context) =>
  //                                       const ForgotPassword()));
  //                         },
  //                         text: 'Forgot Password',
  //                         colors: appColor),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 24),
  //               ],
  //             ),
  //           ),
  //           MyElevatedButton(
  //               onPressed: () {
  //                 Navigator.push(
  //                     context, MaterialPageRoute(builder: (context) => Home()));
  //               },
  //               text: const Icon(Icons.arrow_forward),
  //               height: 40,
  //               width: 40),
  //           const SizedBox(height: 34),
  //           Container(
  //             padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
  //             height: 50,
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 // Column(
  //                 //   children: [
  //                 //     imageButton('lib/assets/images/google.png',
  //                 //         'Login with Google', Colors.red),
  //                 //     imageButton('lib/assets/images/linkedin.png',
  //                 //         'Login with Linkedin', linkedinColor),
  //                 //   ],
  //                 // ),
  //                 const SizedBox(height: 0),
  //                 Row(
  //                   mainAxisAlignment: MainAxisAlignment.center,
  //                   children: [
  //                     blackText('Dont have an account?'),
  //                     MyTextButton(
  //                         onPressed: () {
  //                           Navigator.push(
  //                               context,
  //                               MaterialPageRoute(
  //                                   builder: (context) => const Register()));
  //                         },
  //                         colors: appColor,
  //                         text: "Sign up")
  //                   ],
  //                 )
  //               ],
  //             ),
  //           )
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // Widget _buildBottomNavigationBar() {
  //   return ;
  // }

  imageButton(image, name, color) {
    return Container(
        width: double.infinity,
        height: 46,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  name,
                  style: const TextStyle(
                      fontFamily: 'medium', fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              child: Image.asset(
                image,
                width: 24,
                height: 24,
              ),
            ),
          ],
        ));
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

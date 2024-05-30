import 'dart:async';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hirejobindia/components/styles.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controllers/registrationss/registration_controller.dart';
import '../../../models/city_model.dart';
import '../../../models/state_model.dart';
import '../../../widget/elevated_button.dart';
import '../../../widget/text_btn.dart';
import 'login.dart';

enum Gender { male, female, other }

class RegistrationPage extends StatelessWidget {
  final RegistrationController _profileController =
      Get.put(RegistrationController());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _stateIdController = TextEditingController();
  final TextEditingController _cityIdController = TextEditingController();
  final TextEditingController _genderNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _cvFilePathController = TextEditingController();

  Uint8List? _cvFileContent;
  Gender? _selectedGender = Gender.male;

  Future<void> _checkAndRequestPermissions() async {
    if (await Permission.storage.request().isGranted) {
      _selectCVFile();
    } else {
      await Permission.storage.request();
      if (await Permission.storage.isGranted) {
        _selectCVFile();
      } else {
        print('Storage permission is required to access files.');
      }
    }
  }

  Future<void> _selectCVFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
        withData: true, // Ensure the file picker reads the file data
      );
      if (result != null && result.files.isNotEmpty) {
        PlatformFile file = result.files.first;
        print('Selected file: ${file.name}, path: ${file.path}');
        if (file.bytes != null) {
          _cvFilePathController.text = file.name;
          _cvFileContent = file.bytes!;
          print('File size: ${_cvFileContent!.length} bytes');
        } else {
          print('Failed to read file content: File bytes are null');
        }
      } else {
        print('No file selected');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  var selectedDate = DateTime.now().obs;

  chooseDate() async {
    DateTime? newpickedDate = await showDatePicker(
      context: Get.context!,
      initialDate: selectedDate.value,
      firstDate: DateTime(1900),
      lastDate: DateTime(2025),
      initialEntryMode: DatePickerEntryMode.input,
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Select DOB',
      cancelText: 'Close',
      confirmText: 'Confirm',
      errorFormatText: 'Enter valid date',
      errorInvalidText: 'Enter valid date range',
      fieldLabelText: 'Selected Date',
      //fieldHintText: 'Month/Date/Year',
      //selectableDayPredicate: disableDate,
    );
    if (newpickedDate != null) {
      selectedDate.value = newpickedDate;
      _dateOfBirthController
        ..text = DateFormat('yyyy-MM-d').format(selectedDate.value).toString()
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateOfBirthController.text.length,
            affinity: TextAffinity.upstream));
    }
    // if (pickedDate != null && pickedDate != selectedDate) {
    //   selectedDate.value = pickedDate;
    //   appointmentController.text =
    //       DateFormat('DD-MM-yyyy').format(selectedDate.value).toString();
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(2.0),
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 0.1, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 20.0,
                  )
                ]),
            child: Container(
              padding: const EdgeInsets.all(6),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    keyboardType: TextInputType.name,
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      suffixIcon: Icon(
                        Icons.person,
                        size: 23,
                        color: Colors.black12,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      suffixIcon: Icon(
                        Icons.email,
                        size: 23,
                        color: Colors.black12,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                  TextField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      suffixIcon: Icon(
                        Icons.lock,
                        size: 23,
                        color: Colors.black12,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.phone,
                    //maxLength: 10,
                    controller: _mobileNumberController,
                    decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      suffixIcon: Icon(
                        Icons.phone_android_outlined,
                        size: 23,
                        color: Colors.black12,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _experienceController,
                    decoration: InputDecoration(
                      labelText: 'Experience',
                      suffixIcon: Icon(
                        Icons.account_box,
                        size: 23,
                        color: Colors.black12,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  Obx(
                    () => DropdownButtonFormField<StateModelss>(
                        value: _profileController.selectedState.value,
                        decoration: InputDecoration(
                          labelText: 'State',
                          suffixIcon: Icon(
                            Icons.place_outlined,
                            size: 23,
                            color: Colors.black12,
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.black54, fontSize: 15),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: appColor),
                          ),
                        ),
                        hint: Text('Select State'),
                        items:
                            _profileController.states.map((StateModelss items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items.sName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.015,
                              ),
                            ),
                          );
                        }).toList(),
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (StateModelss? newValue) {
                          _profileController.selectedState.value = newValue!;
                          _profileController.selectedCity.value = null;
                        }),
                  ),

                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  Obx(
                    () => DropdownButtonFormField<CityModell>(
                        value: _profileController.selectedCity.value,
                        decoration: InputDecoration(
                          labelText: 'City',
                          suffixIcon: Icon(
                            Icons.place_outlined,
                            size: 23,
                            color: Colors.black12,
                          ),
                          labelStyle: const TextStyle(
                              color: Colors.black54, fontSize: 15),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: appColor),
                          ),
                        ),
                        hint: Text('Select City'),
                        items:
                            _profileController.cities.map((CityModell items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items.cityName,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: size.height * 0.015,
                              ),
                            ),
                          );
                        }).toList(),
                        onTap: () {
                          _profileController.refresh();
                        },
                        validator: (value) =>
                            value == null ? 'field required' : null,
                        onChanged: (CityModell? newValue) {
                          _profileController.selectedCity.value = newValue!;
                        }),
                  ),

                  // TextField(
                  //   controller: _stateIdController,
                  //   decoration: InputDecoration(labelText: 'State ID'),
                  // ),
                  // TextField(
                  //   controller: _cityIdController,
                  //   decoration: InputDecoration(labelText: 'City ID'),
                  // ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),

                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Choose Gender',
                      style: TextStyle(
                        fontSize: size.height * 0.016,

                        /// fontWeight: FontWeight.bold,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.005,
                  ),

                  InkWell(
                    onTap: () => _profileController.selectedGender.value,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Obx(
                            () => RadioListTile(
                              title: Text(
                                'Male',
                                style: TextStyle(
                                  fontSize: size.height * 0.014,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),

                              // title: Text("Male"),
                              value:
                                  //_nurseBooking1Controller.selectedshift.value,
                                  "Male",
                              groupValue:
                                  _profileController.selectedGender.value,
                              onChanged: (value) {
                                _profileController.onChangeShifts(value!);
                                // setState(() {
                                //   gender = value.toString();
                                // });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => RadioListTile(
                              title: Text(
                                'Female',
                                style: TextStyle(
                                  fontSize: size.height * 0.014,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              // title: Text("Male"),
                              value:
                                  //_nurseBooking1Controller.selectedshift.value,
                                  "Female",
                              groupValue:
                                  _profileController.selectedGender.value,
                              onChanged: (value) {
                                _profileController.onChangeShifts(value!);
                                // setState(() {
                                //   gender = value.toString();
                                // });
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: Obx(
                            () => RadioListTile(
                              title: Text(
                                'Other',
                                style: TextStyle(
                                  fontSize: size.height * 0.014,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              visualDensity: VisualDensity(
                                horizontal: VisualDensity.minimumDensity,
                                vertical: VisualDensity.minimumDensity,
                              ),
                              // title: Text("Male"),
                              value:
                                  //_nurseBooking1Controller.selectedshift.value,
                                  "Other",
                              groupValue:
                                  _profileController.selectedGender.value,
                              onChanged: (value) {
                                _profileController.onChangeShifts(value!);
                                // setState(() {
                                //   gender = value.toString();
                                // });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),

                  // TextField(
                  //   controller: _genderNameController,
                  //   decoration: InputDecoration(labelText: 'Gender Name'),
                  // ),

                  TextField(
                    textAlign: TextAlign.left,
                    controller: _dateOfBirthController,
                    onTap: () {
                      chooseDate();
                    },
                    cursorColor: appColor,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        size: 23,
                        color: Colors.black12,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                  // TextField(
                  //   controller: _dateOfBirthController,
                  //   decoration: InputDecoration(
                  //     labelText: 'Date of Birth',
                  //     suffixIcon: Icon(
                  //       Icons.calendar_today,
                  //       size: 23,
                  //       color: Colors.black12,
                  //     ),
                  //     labelStyle:
                  //         const TextStyle(color: Colors.black54, fontSize: 15),
                  //     focusedBorder: const UnderlineInputBorder(
                  //       borderSide: BorderSide(color: appColor),
                  //     ),
                  //   ),
                  // ),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      suffixIcon: Icon(
                        Icons.pin_drop_outlined,
                        size: 23,
                        color: Colors.black12,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _pincodeController,
                    decoration: InputDecoration(
                      labelText: 'Pincode',
                      suffixIcon: Icon(
                        Icons.pin,
                        size: 23,
                        color: Colors.black12,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.black54, fontSize: 15),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(color: appColor),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      // Expanded widget to ensure the TextField takes the remaining width
                      Expanded(
                        child: TextField(
                          controller: _cvFilePathController,
                          decoration: InputDecoration(labelText: 'CV File'),
                          enabled: false,
                        ),
                      ),
                      SizedBox(
                          width:
                              10), // Add some spacing between the TextField and the Button
                      Container(
                        width: 80,
                        height: 35,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ElevatedButton(
                          onPressed: _checkAndRequestPermissions,
                          style: ElevatedButton.styleFrom(
                            primary: appColor, // Button color
                            onPrimary: Colors.white, // Text color
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10), // Rounded corners
                            ),
                          ),
                          child: Text(
                            'Upload\n     CV',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // TextField(
                  //   controller: _cvFilePathController,
                  //   decoration: InputDecoration(labelText: 'CV File Path'),
                  //   enabled: false,
                  // ),
                  // SizedBox(height: 20),
                  // ElevatedButton(
                  //   onPressed: _checkAndRequestPermissions,
                  //   child: Text('Select CV File'),
                  // ),
                  SizedBox(height: 40),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_cvFileContent != null) {
                  //       _profileController.createProfile(
                  //         fullName: _nameController.text,
                  //         emailID: _emailController.text,
                  //         password: _passwordController.text,
                  //         mobileNumber: _mobileNumberController.text,
                  //         experience: _experienceController.text,
                  //         stateId: _stateIdController.text,
                  //         cityId: _cityIdController.text,
                  //         genderName: _genderNameController.text,
                  //         dateOfBirth: _dateOfBirthController.text,
                  //         address: _addressController.text,
                  //         pincode: _pincodeController.text,
                  //         cvFileContent: _cvFileContent!, // Pass file content
                  //         cvFileName:
                  //             _cvFilePathController.text, // Pass file name
                  //       );
                  //     } else {
                  //       print('Please select a CV file');
                  //     }
                  //   },
                  //   child: Text('Create Profile'),
                  // ),

                  MyElevatedButton(
                      onPressed: () async {
                        if (_cvFileContent != null) {
                          _profileController.createProfile(
                            fullName: _nameController.text,
                            emailID: _emailController.text,
                            password: _passwordController.text,
                            mobileNumber: _mobileNumberController.text,
                            experience: _experienceController.text,
                            stateId: _profileController.selectedState.value!.id
                                .toString(),
                            cityId: _profileController.selectedCity.value!.id
                                .toString(),
                            genderName: _profileController.selectedGender.value,
                            dateOfBirth: _dateOfBirthController.text,
                            address: _addressController.text,
                            pincode: _pincodeController.text,
                            cvFileContent: _cvFileContent!, // Pass file content
                            cvFileName:
                                _cvFilePathController.text, // Pass file name
                          );
                          // await Future.delayed(Duration(seconds: 3));

                          ///Clear dropdown value
                          //_profileController.selectedState.value = null;
                          // _profileController.selectedCity.value = null;
                        } else {
                          print('Please select a CV file');
                        }
                        // Navigator.push(
                        //     context, MaterialPageRoute(builder: (context) => Home()));
                      },
                      text: const Icon(Icons.arrow_forward),
                      height: 40,
                      width: 40),
                  Container(
                    padding: const EdgeInsets.all(24),
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // Column(
                        //   children: [
                        //     imageButton('lib/assets/images/google.png',
                        //         'Login with Google', Colors.red),
                        //     imageButton('lib/assets/images/linkedin.png',
                        //         'Login with Linkedin', linkedinColor),
                        //   ],
                        // ),
                        const SizedBox(height: 0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            blackText('Already have an account?'),
                            MyTextButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Login()));
                                },
                                colors: appColor,
                                text: "Sign in")
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(150),
      child: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        flexibleSpace: _buildHeader(),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
        width: double.infinity,
        height: 200,
        //MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            appColor,
            appColor2,
          ],
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 12,
            ),
            logoImg(),
            const Text(
              'Welcome to Hire Job India',
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontFamily: 'medium'),
            ),
            Text(
              'SIGNUP With US.',
              style: TextStyle(
                  color: Colors.indigo.shade900,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'medium'),
            ),
          ],
        ));
  }

  logoImg() {
    return Image.asset(
      'lib/assets/logo/hirelogo11.png',
      // 'lib/assets/images/job.png',
      //color: Colors.white,
      width: 100,
      height: 80,
    );
  }
}

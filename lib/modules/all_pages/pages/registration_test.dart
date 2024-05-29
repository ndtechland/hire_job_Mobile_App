import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/registrationss/registration_controller.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController _profileController =
      Get.put(RegistrationController());

  final TextEditingController _nameController =
      TextEditingController(text: "ram");
  final TextEditingController _emailController =
      TextEditingController(text: "r@gmail.com");

  final TextEditingController _passwordController =
      TextEditingController(text: "12345");
  final TextEditingController _mobileNumberController =
      TextEditingController(text: "4567665566");
  final TextEditingController _experienceController =
      TextEditingController(text: "2");
  final TextEditingController _stateIdController =
      TextEditingController(text: "32");
  final TextEditingController _cityIdController =
      TextEditingController(text: "2");
  final TextEditingController _genderNameController =
      TextEditingController(text: "Male");
  final TextEditingController _dateOfBirthController =
      TextEditingController(text: "2024-05-24T00:00:00");
  final TextEditingController _addressController =
      TextEditingController(text: "delhi");
  final TextEditingController _pincodeController =
      TextEditingController(text: "110096");
  final TextEditingController _cvFilePathController = TextEditingController();

  Future<void> _selectCVFile() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.isNotEmpty) {
      _cvFilePathController.text = result.files.first.path!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              //
              TextField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'name')),
              TextField(
                  controller: _emailController,
                  decoration: InputDecoration(labelText: 'email')),
              TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(labelText: 'Password')),
              TextField(
                  controller: _mobileNumberController,
                  decoration: InputDecoration(labelText: 'Mobile Number')),
              TextField(
                  controller: _experienceController,
                  decoration: InputDecoration(labelText: 'Experience')),
              TextField(
                  controller: _stateIdController,
                  decoration: InputDecoration(labelText: 'State ID')),
              TextField(
                  controller: _cityIdController,
                  decoration: InputDecoration(labelText: 'City ID')),
              TextField(
                  controller: _genderNameController,
                  decoration: InputDecoration(labelText: 'Gender Name')),
              TextField(
                  controller: _dateOfBirthController,
                  decoration: InputDecoration(labelText: 'Date of Birth')),
              TextField(
                  controller: _addressController,
                  decoration: InputDecoration(labelText: 'Address')),
              TextField(
                  controller: _pincodeController,
                  decoration: InputDecoration(labelText: 'Pincode')),
              TextField(
                  controller: _cvFilePathController,
                  decoration: InputDecoration(labelText: 'CV File Path'),
                  enabled: false),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _selectCVFile,
                child: Text('Select CV File'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _profileController.createProfile(
                    FullName: _nameController.text,
                    EmailID: _emailController.text,
                    password: _passwordController.text,
                    mobileNumber: _mobileNumberController.text,
                    experience: _experienceController.text,
                    stateId: _stateIdController.text,
                    cityId: _cityIdController.text,
                    genderName: _genderNameController.text,
                    dateOfBirth: _dateOfBirthController.text,
                    address: _addressController.text,
                    pincode: _pincodeController.text,
                    cvFilePath: _cvFilePathController.text,
                  );
                },
                child: Text('Create Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

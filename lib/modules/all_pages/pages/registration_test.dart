import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../controllers/registrationss/registration_controller.dart';

class RegistrationPage extends StatelessWidget {
  final RegistrationController _profileController =
      Get.put(RegistrationController());

  final TextEditingController _nameController =
      TextEditingController(text: "rsame");
  final TextEditingController _emailController =
      TextEditingController(text: "res@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "12345");
  final TextEditingController _mobileNumberController =
      TextEditingController(text: "6067665566");
  final TextEditingController _experienceController =
      TextEditingController(text: "2");
  final TextEditingController _stateIdController =
      TextEditingController(text: "32");
  final TextEditingController _cityIdController =
      TextEditingController(text: "2");
  final TextEditingController _genderNameController =
      TextEditingController(text: "Male");
  final TextEditingController _dateOfBirthController =
      TextEditingController(text: "2000-05-24T00:00:00");
  final TextEditingController _addressController =
      TextEditingController(text: "delhi");
  final TextEditingController _pincodeController =
      TextEditingController(text: "110096");
  final TextEditingController _cvFilePathController = TextEditingController();

  Uint8List? _cvFileContent;

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
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
              ),
              TextField(
                controller: _mobileNumberController,
                decoration: InputDecoration(labelText: 'Mobile Number'),
              ),
              TextField(
                controller: _experienceController,
                decoration: InputDecoration(labelText: 'Experience'),
              ),
              TextField(
                controller: _stateIdController,
                decoration: InputDecoration(labelText: 'State ID'),
              ),
              TextField(
                controller: _cityIdController,
                decoration: InputDecoration(labelText: 'City ID'),
              ),
              TextField(
                controller: _genderNameController,
                decoration: InputDecoration(labelText: 'Gender Name'),
              ),
              TextField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
              ),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
              ),
              TextField(
                controller: _pincodeController,
                decoration: InputDecoration(labelText: 'Pincode'),
              ),
              TextField(
                controller: _cvFilePathController,
                decoration: InputDecoration(labelText: 'CV File Path'),
                enabled: false,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _checkAndRequestPermissions,
                child: Text('Select CV File'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_cvFileContent != null) {
                    _profileController.createProfile(
                      fullName: _nameController.text,
                      emailID: _emailController.text,
                      password: _passwordController.text,
                      mobileNumber: _mobileNumberController.text,
                      experience: _experienceController.text,
                      stateId: _stateIdController.text,
                      cityId: _cityIdController.text,
                      genderName: _genderNameController.text,
                      dateOfBirth: _dateOfBirthController.text,
                      address: _addressController.text,
                      pincode: _pincodeController.text,
                      cvFileContent: _cvFileContent!, // Pass file content
                      cvFileName: _cvFilePathController.text, // Pass file name
                    );
                  } else {
                    print('Please select a CV file');
                  }
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

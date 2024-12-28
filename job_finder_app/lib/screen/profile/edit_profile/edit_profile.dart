import 'package:flutter/material.dart';

import 'widgets/custom_text_field.dart';
import 'widgets/date_picker_field.dart';
import 'widgets/profile_image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String name = "Mistire Daniel";
  String email = "mistiredan@gmail.com";
  String mobileNumber = "+251123456789";
  String dateOfBirth = "2002-04-29";
  String jobTitle = "Software Developer";
  String address = "123 Main Street";
  String? profileImagePath;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture Section
            ProfileImagePicker(
              profileImagePath: profileImagePath,
              onImagePicked: (path) {
                setState(() {
                  profileImagePath = path;
                });
              },
            ),
            const SizedBox(height: 20),
            // Form Section
            Form(
              key: _formKey,
              child: Column(
                children: [
                  CustomTextField(
                    label: "Name",
                    initialValue: name,
                    onChanged: (value) {
                      setState(() {
                        name = value!;
                      });
                    },
                  ),
                  CustomTextField(
                    label: "Email Address",
                    initialValue: email,
                    onChanged: (value) {
                      setState(() {
                        email = value!;
                      });
                    },
                  ),
                  CustomTextField(
                    label: "Mobile Number",
                    initialValue: mobileNumber,
                    onChanged: (value) {
                      setState(() {
                        mobileNumber = value!;
                      });
                    },
                  ),
                  DatePickerField(
                    label: "Date of Birth",
                    initialValue: dateOfBirth,
                    onDatePicked: (value) {
                      setState(() {
                        dateOfBirth = value;
                      });
                    },
                  ),
                  CustomTextField(
                    label: "Job Title",
                    initialValue: jobTitle,
                    onChanged: (value) {
                      setState(() {
                        jobTitle = value!;
                      });
                    },
                  ),
                  CustomTextField(
                    label: "Address",
                    initialValue: address,
                    onChanged: (value) {
                      setState(() {
                        address = value!;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Update Button
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile Updated')),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding:
                    const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                "Update",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

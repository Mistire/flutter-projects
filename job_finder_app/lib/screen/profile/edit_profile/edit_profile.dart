import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  String name = "";
  String email = "";
  String mobileNumber = "";
  String dateOfBirth = "";
  String jobTitle = "";
  String address = "";
  String? profileImagePath;
  late User _user;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser!;

    // Fetch the user's current profile data from Firestore
    _fetchUserProfile();
  }

  // Fetch user profile from Firestore
  Future<void> _fetchUserProfile() async {
    try {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(_user.uid).get();
      if (userDoc.exists) {
        setState(() {
          name = userDoc['name'] ?? _user.displayName ?? 'No name provided';
          email = _user.email ?? 'No email provided';
          mobileNumber = userDoc['mobileNumber'] ?? '';
          dateOfBirth = userDoc['dateOfBirth'] ?? '';
          jobTitle = userDoc['jobTitle'] ?? '';
          address = userDoc['address'] ?? '';
          profileImagePath = userDoc['profileImagePath'];
        });
      }
    } catch (e) {
      print("Error fetching user profile: $e");
    }
  }

  // Function to update user profile
  Future<void> _updateProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        // If a new image is picked, upload it to Firebase Storage
        String? imageUrl;
        if (profileImagePath != null) {
          File imageFile = File(profileImagePath!);
          UploadTask uploadTask = _storage
              .ref('profile_pictures/${_user.uid}.jpg')
              .putFile(imageFile);
          TaskSnapshot snapshot = await uploadTask;
          imageUrl = await snapshot.ref.getDownloadURL();
        }

        // Update the user's profile in Firestore
        await _firestore.collection('users').doc(_user.uid).set({
          'name': name,
          'email': email,
          'mobileNumber': mobileNumber,
          'dateOfBirth': dateOfBirth,
          'jobTitle': jobTitle,
          'address': address,
          'profileImagePath': imageUrl ?? profileImagePath,
        }, SetOptions(merge: true));

        // Optionally update the Firebase Authentication display name
        await _user.updateDisplayName(name);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile Updated')),
        );
      } catch (e) {
        print("Error updating profile: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to update profile')),
        );
      }
    }
  }

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
                    readOnly: true, // Email should be read-only
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
              onPressed: _updateProfile,
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

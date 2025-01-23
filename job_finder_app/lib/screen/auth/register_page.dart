import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'login_page.dart';
import 'widgets/custom_form_field.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  RegisterPage({super.key});

  Future<void> registerUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Password must be at least 8 characters long.')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match.')),
      );
      return;
    }

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful!')),
      );

      // Navigate to the home screen or another page
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } on FirebaseAuthException catch (e) {
      String message;
      if (e.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists for this email.';
      } else if (e.code == 'invalid-email') {
        message = 'The email address is invalid.';
      } else {
        message = 'Registration failed: ${e.message}';
      }
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An unexpected error occurred: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF438187);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              const Text(
                "Workify",
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                  fontFamily: 'Roboto',
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Register now',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Enter your information below',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              CustomFormField(
                hintText: 'Name',
                controller: nameController,
              ),
              const SizedBox(height: 15),
              CustomFormField(
                hintText: 'Email Address',
                controller: emailController,
              ),
              const SizedBox(height: 15),
              CustomFormField(
                hintText: 'Password',
                controller: passwordController,
                isPassword: true,
              ),
              const SizedBox(height: 15),
              CustomFormField(
                hintText: 'Confirm Password',
                controller: confirmPasswordController,
                isPassword: true,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  onPressed: () => registerUser(context),
                  child: const Text(
                    'Register',
                    style: TextStyle(
                        color: Color.fromRGBO(255, 255, 255, 1), fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already a member? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(color: primaryColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

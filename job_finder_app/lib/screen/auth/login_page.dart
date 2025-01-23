import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_finder_app/screen/home/home.dart';
import 'register_page.dart';
import 'widgets/custom_form_field.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  Future<void> loginUser(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validate email and password
    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your password.')),
      );
      return;
    }

    try {
      // Sign in using Firebase authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // After successful login, show success message and navigate to home page
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login successful!')),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } on FirebaseAuthException catch (e) {
      // Handle Firebase authentication errors
      String errorMessage = 'An error occurred. Please try again later.';
      if (e.code == 'user-not-found') {
        errorMessage = 'An account with this email does not exist.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password provided for this account.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
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
                "Welcome Back!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Sign in to continue',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Handle Google authentication
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.google,
                      color: primaryColor,
                    ),
                    label: const Text('Google'),
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Handle LinkedIn authentication
                    },
                    icon: const FaIcon(
                      FontAwesomeIcons.linkedin,
                      color: primaryColor,
                    ),
                    label: const Text('LinkedIn'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'or login with your email',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  onTap: () {
                    // Handle password recovery
                  },
                  child: const Text(
                    'Forgot Password?',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
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
                  onPressed: () => loginUser(context),
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: const Text(
                      'Register Now',
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

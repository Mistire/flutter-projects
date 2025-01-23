import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../auth/login_page.dart';
import '../../profile/profile_page.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  Future<void> logOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
        (route) => false, // Remove all previous routes
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error logging out: $e')),
      );
    }
  }

  Future<void> login(
      BuildContext context, String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Incorrect password provided for that user.';
      } else if (e.code == 'invalid-email') {
        errorMessage = 'The email address is badly formatted.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }
      // Show the error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user's information
    final User? user = FirebaseAuth.instance.currentUser;

    // Check if user is not null, then use displayName, else fall back to email
    final String displayName = user != null
        ? user.displayName ??
            user.email!.split('@')[0] // Display name or email username
        : 'User'; // Fallback to 'User' if the user is not logged in

    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top,
        left: 25,
        right: 25,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side: Welcome text and username
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome home',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  displayName, // Display the username (either displayName or email part before '@')
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    overflow: TextOverflow.ellipsis, // Handle long names
                  ),
                ),
              ],
            ),
          ),
          // Right side: Notifications, profile image, and logout button
          Row(
            children: [
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Stack(
                  children: [
                    const Icon(
                      Icons.notifications_none_outlined,
                      size: 30,
                      color: Colors.grey,
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  // Navigate to the profile page when the image is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                    ),
                  );
                },
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.jpg', // Path to your profile image
                    width: 40,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.grey),
                onPressed: () => logOut(context), // Call the logout function
              ),
            ],
          ),
        ],
      ),
    );
  }
}

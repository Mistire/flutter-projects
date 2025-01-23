import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:job_finder_app/screen/profile/edit_profile/edit_profile.dart';

class ProfileHeader extends StatelessWidget {
  final Color primaryColor;

  const ProfileHeader({super.key, required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    // Get the current user from Firebase Auth
    final user = FirebaseAuth.instance.currentUser;

    // If the user is not logged in, return a default placeholder
    if (user == null) {
      return Container(
        decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: const [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              "User not logged in",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Please log in to see your profile.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    // Extract the name from the email by splitting the email at '@' symbol
    String displayName =
        user.displayName ?? user.email?.split('@')[0] ?? 'No name provided';

    return Container(
      decoration: BoxDecoration(
        color: primaryColor,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Stack(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/images/profile.jpg'),
              ),
              Positioned(
                bottom: 0,
                right: -0, // Adjust this value for positioning
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => EditProfilePage(),
                    ));
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            displayName,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user.email ?? 'No email provided',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: const [
                  Text(
                    "10",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Job Applied",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.white70,
              ),
              Column(
                children: const [
                  Text(
                    "Jan 2020",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Member Since",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Container(
                height: 40,
                width: 1,
                color: Colors.white70,
              ),
              Column(
                children: const [
                  Text(
                    "5",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Interviews",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

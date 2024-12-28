import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:job_finder_app/screen/profile/edit_profile/edit_profile.dart';
import 'screen/auth/login_page.dart';
import 'screen/auth/register_page.dart';
import 'screen/home/home.dart';
import 'screen/onboarding/onboarding_page.dart';
import 'screen/profile/profile_page.dart';
import 'screen/splash/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Job Finder app',
        theme: ThemeData(
            primaryColor: const Color(0xFF438187),
            colorScheme: ColorScheme.fromSwatch()
                .copyWith(secondary: const Color(0xFFFED408))),
        // home: HomePage());
        // home: RegisterPage());
        // home: LoginPage());
        // home: SplashPage());
        // home: OnboardingPage());
        home: ProfilePage());
    // home: EditProfilePage());
  }
}

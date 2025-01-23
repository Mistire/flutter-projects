import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'job_uploader.dart';
import 'models/job.dart';
import 'screen/splash/splash_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    print('Firebase initialized successfully!');

    // Fetch jobs from Firestore
    List<Job> jobsToUpload = await JobUploader().fetchJobs();
    
    if (jobsToUpload.isNotEmpty) {
      // Upload the jobs to Firestore
      await JobUploader().uploadJobs(jobsToUpload);
      print('Jobs uploaded successfully');
    } else {
      print('No jobs to upload');
    }
    
  } catch (e) {
    print('Failed to initialize Firebase or upload jobs: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Job Finder App',
      theme: ThemeData(
        primaryColor: const Color(0xFF438187),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFFED408)),
      ),
      home: SplashPage(),  // Set the home to SplashPage
    );
  }
}

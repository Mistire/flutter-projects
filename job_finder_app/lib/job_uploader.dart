import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/job.dart';

class JobUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch jobs from Firestore
  Future<List<Job>> fetchJobs() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('jobs').get();
      return snapshot.docs.map((doc) => Job.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching jobs: $e");
      return [];
    }
  }

  // Function to upload job data to Firestore
  Future<void> uploadJobs(List<Job> jobs) async {
    for (var job in jobs) {
      await _firestore.collection('jobs').add({
        'company': job.company,
        'logoUrl': job.logoUrl,
        'isMark': job.isMark,
        'title': job.title,
        'location': job.location,
        'time': job.time,
        'req': job.req,
      }).catchError((e) {
        print("Error uploading job data: $e");
      });
    }
  }
}

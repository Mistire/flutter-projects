import 'package:cloud_firestore/cloud_firestore.dart';
import 'models/job.dart';

class JobUploader {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Function to fetch jobs from Firestore with optional filtering and pagination
  Future<List<Job>> fetchJobs({String? categoryFilter, int limit = 20}) async {
    try {
      Query query = _firestore.collection('jobs');

      if (categoryFilter != null) {
        query = query.where('category', isEqualTo: categoryFilter);
      }

      query = query.limit(limit);

      QuerySnapshot snapshot = await query.get();
      return snapshot.docs.map((doc) => Job.fromFirestore(doc)).toList();
    } catch (e) {
      print("Error fetching jobs: $e");
      return [];
    }
  }

  // Function to upload job data to Firestore using batch for efficiency
  Future<void> uploadJobs(List<Job> jobs) async {
    WriteBatch batch = _firestore.batch();

    for (var job in jobs) {
      DocumentReference docRef = _firestore.collection('jobs').doc();
      batch.set(docRef, {
        'company': job.company,
        'logoUrl': job.logoUrl,
        'isMark': job.isMark,
        'title': job.title,
        'location': job.location,
        'time': job.time,
        'req': job.req,
      });
    }

    try {
      await batch.commit();
      print("Jobs uploaded successfully!");
    } catch (e) {
      print("Error uploading job data: $e");
    }
  }
}

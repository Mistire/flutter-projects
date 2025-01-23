import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  final String id;
  final String company;
  final String logoUrl;
  final String title;
  final String location;
  final String time;
  bool isMark;
  final List<String> req;

  Job({
    required this.id,
    required this.company,
    required this.logoUrl,
    required this.title,
    required this.location,
    required this.time,
    required this.isMark,
    required this.req,
  });

  // Create a Job from Firestore data
  factory Job.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Job(
      id: doc.id,  // Get the Firestore document ID
      company: data['company'],
      logoUrl: data['logoUrl'],
      title: data['title'],
      location: data['location'],
      time: data['time'],
      isMark: data['isMark'] ?? false,  // Default to false if isMark is missing
      req: List<String>.from(data['req'] ?? []),  // Ensure req is a list
    );
  }

  // Convert a Job object to a map to store in Firestore
  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'logoUrl': logoUrl,
      'title': title,
      'location': location,
      'time': time,
      'isMark': isMark,
      'req': req,
    };
  }
}

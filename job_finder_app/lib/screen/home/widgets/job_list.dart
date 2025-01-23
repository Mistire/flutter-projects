import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/job.dart';
import 'job_detail.dart';
import 'job_item.dart';

class JobList extends StatelessWidget {
  final bool onlyBookmarked; // Parameter to filter jobs

  JobList({super.key, this.onlyBookmarked = false}); // Default shows all jobs

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetching job data from Firestore with optional filtering
  Stream<List<Job>> _getJobs() {
    Query query = _firestore.collection('jobs');

    if (onlyBookmarked) {
      query = query.where('isMark', isEqualTo: true); // Filter bookmarked jobs
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return Job(
          id: doc.id,
          company: doc['company'],
          logoUrl: doc['logoUrl'],
          title: doc['title'],
          location: doc['location'],
          time: doc['time'],
          isMark: doc['isMark'],
          req: List<String>.from(doc['req']),
        );
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Job>>(
      stream: _getJobs(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text(
              onlyBookmarked ? 'No saved jobs available' : 'No jobs available',
            ),
          );
        }

        final jobList = snapshot.data!;

        return Container(
          margin: const EdgeInsets.symmetric(vertical: 25),
          height: 180,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => JobDetail(jobList[index]),
                );
              },
              child: JobItem(jobList[index]),
            ),
            separatorBuilder: (_, index) => const SizedBox(
              width: 15,
            ),
            itemCount: jobList.length,
          ),
        );
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:job_finder_app/models/job.dart';
import 'package:job_finder_app/screen/home/widgets/job_item.dart';

import 'job_detail.dart';

class JobList extends StatelessWidget {
  JobList({super.key});

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetching job data from Firestore
  Stream<List<Job>> _getJobs() {
    return _firestore.collection('jobs').snapshots().map((snapshot) {
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
          return Center(child: Text('No jobs available'));
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

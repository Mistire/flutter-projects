import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_finder_app/models/job.dart';
import 'package:job_finder_app/screen/home/widgets/job_item.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Fetch jobs from Firestore
  Future<List<Job>> _fetchJobs() async {
    final jobCollection = _firestore.collection('jobs');
    final querySnapshot = await jobCollection.get();
    return querySnapshot.docs.map((doc) {
      return Job.fromFirestore(doc);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(), // Fetch jobs when the widget is built
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData && snapshot.data!.isEmpty) {
          return const Center(child: Text("No jobs found"));
        } else if (snapshot.hasData) {
          final jobList = snapshot.data!;
          return Container(
            margin: const EdgeInsets.only(top: 25),
            height: 500,
            child: ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              itemBuilder: (context, index) => JobItem(
                jobList[index],
                showTime: true,
              ),
              separatorBuilder: (_, index) => const SizedBox(
                height: 20,
              ),
              itemCount: jobList.length,
            ),
          );
        } else {
          return const Center(child: Text("No data available"));
        }
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../models/job.dart';
import '../../home/widgets/job_item.dart';

class SearchList extends StatefulWidget {
  final String query; // Search input query
  final List<String> filters; // Active filters

  const SearchList({super.key, required this.query, required this.filters});

  @override
  _SearchListState createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Job>> _fetchJobs() async {
    Query<Map<String, dynamic>> jobCollection = _firestore.collection('jobs');

    // Apply filters dynamically based on job titles
    if (widget.filters.isNotEmpty) {
      jobCollection = jobCollection.where(
        'title',
        whereIn: widget.filters,
      );
    }

    final querySnapshot = await jobCollection.get();

    // Filter by search query (starts with logic)
    return querySnapshot.docs
        .map((doc) => Job.fromFirestore(doc))
        .where((job) =>
            job.title.toLowerCase().startsWith(widget.query.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Job>>(
      future: _fetchJobs(),
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
              separatorBuilder: (_, index) => const SizedBox(height: 20),
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

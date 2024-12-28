import 'package:flutter/material.dart';
import 'package:job_finder_app/models/job.dart';
import 'package:job_finder_app/screen/home/widgets/job_item.dart';

class SearchList extends StatelessWidget {
  final List<Job> jobList;

  SearchList({super.key}) : jobList = Job.generateJobs();
  @override
  Widget build(BuildContext context) {
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
        ));
  }
}

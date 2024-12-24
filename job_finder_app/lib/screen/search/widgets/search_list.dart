import 'package:flutter/material.dart';
import 'package:job_finder_app/models/job.dart';
import 'package:job_finder_app/screen/home/widgets/job_item.dart';

class SearchList extends StatelessWidget {
  final jobList = Job.generateJobs();
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 25),
        height: 500,
        child: ListView.separated(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 25, right: 25, bottom: 25),
          itemBuilder: (context, index) => JobItem(
            jobList[index],
            showTime: true,
          ),
          separatorBuilder: (_, index) => SizedBox(
            height: 20,
          ),
          itemCount: jobList.length,
        ));
  }
}

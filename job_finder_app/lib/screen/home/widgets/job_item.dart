import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:job_finder_app/models/job.dart';
import 'package:job_finder_app/widgets/icon_text.dart';

class JobItem extends StatefulWidget {
  final Job job;
  final bool showTime;

  const JobItem(this.job, {super.key, this.showTime = false});

  @override
  _JobItemState createState() => _JobItemState();
}

class _JobItemState extends State<JobItem> {
  late bool isBookmarked;

  @override
  void initState() {
    super.initState();
    isBookmarked = widget.job.isMark; // Initialize state based on job data
  }

  Future<void> toggleBookmark() async {
    setState(() {
      isBookmarked = !isBookmarked;
    });

    // Update the job model
    widget.job.isMark = isBookmarked;

    // Save the updated bookmark state to Firestore
    try {
      await FirebaseFirestore.instance
          .collection('jobs') // Assuming the collection is 'jobs'
          .doc(widget.job.id)
          .update({
        'isMark': isBookmarked,
      });
    } catch (e) {
      print("Error updating bookmark: $e");
      // Optionally, show a snack bar or alert the user of the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 270,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).secondaryHeaderColor),
        borderRadius: BorderRadius.circular(30),
        color: Colors.white,
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.1),
                  ),
                  child: Image.asset(widget.job.logoUrl),
                ),
                const SizedBox(width: 10),
                Text(widget.job.company,
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey)),
              ],
            ),
            IconButton(
              icon: Icon(
                isBookmarked ? Icons.bookmark : Icons.bookmark_outline_outlined,
                color: isBookmarked
                    ? Theme.of(context).primaryColor
                    : Colors.black,
              ),
              onPressed: toggleBookmark,
            ),
          ],
        ),
        const SizedBox(height: 15),
        Text(
          widget.job.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconText(Icons.location_on_outlined, widget.job.location),
            if (widget.showTime)
              IconText(Icons.access_time_outlined, widget.job.time),
          ],
        ),
      ]),
    );
  }
}

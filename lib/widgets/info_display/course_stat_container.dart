import 'package:flutter/material.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';

class CourseStatDisplay extends StatelessWidget {
  final String courseName;
  final String courseInfo;
  final int missing;
  final int ungraded;
  final int graded;
  final int total;
  final double padding;

  CourseStatDisplay({required this.courseName, required this.courseInfo, required this.missing, required this.ungraded, required this.graded, required this.total, this.padding = 16.0});

  @override
  Widget build(BuildContext context) {
    var children = [
      CallistoText(courseName, size: 22, textAlign: TextAlign.left),
      CallistoText(courseInfo, size: 15),
    ];

    if (missing != 0) {
      children.add(CallistoText("You have ${missing} missing assingments.", size: 10, color: Theme.of(context).colorScheme.error));
    }

    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        // constraints: BoxConstraints(
        //   maxWidth: double.infinity,
        // ),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary, // Set your desired background color
          borderRadius: BorderRadius.circular(10.0), // Adjust the radius as needed
        ),
        child:  Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: children,
          ),
        )
      ),
    );
  }
}
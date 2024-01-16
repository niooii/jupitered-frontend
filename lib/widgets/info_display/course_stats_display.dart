import 'package:flutter/material.dart';
import 'package:jupiter_frontend/pages/course_screen.dart';
import 'package:jupiter_frontend/widgets/general/callisto_clickable.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/models/course.dart';

class CourseStatDisplay extends StatelessWidget {
  final Course course; 
  final double padding;

  const CourseStatDisplay({super.key, required this.course, this.padding = 16.0});

  @override
  Widget build(BuildContext context) {
    var courseInfoChildren = [
      CallistoText(course.placeAndTime, size: 13),
      CallistoText(course.name, size: 22, textAlign: TextAlign.left),
      CallistoText(course.teacher, size: 15),
    ];

    if (course.missingAssignments != 0) {
      courseInfoChildren.add(CallistoText("You have ${course.missingAssignments} missing assignments.", size: 10, color: Theme.of(context).colorScheme.error));
    }

    return Padding(
      padding: EdgeInsets.all(padding),
      child: CClickable(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) {
            return CourseScreen(course: course);
          }));
        },
        child: Container(
          decoration: BoxDecoration(
            // color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(10.0),
            gradient: LinearGradient(colors: [
              Theme.of(context).colorScheme.tertiary,
              Colors.blue
            ],
            stops: [
              0.65,
              1.0
            ]
            )
          ),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: courseInfoChildren,
                    ),
                    // Add a Spacer to push the text to the far right
                    const Spacer(),
                    // change this widget.
                    CallistoText("${course.ave}%", size: 22, weight: FontWeight.w600,)
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}

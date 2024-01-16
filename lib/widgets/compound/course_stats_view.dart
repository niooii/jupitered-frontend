import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/info_display/course_stats_display.dart';

const List<String> sortByLabels = ["Grade (Highest)", "Grade (Lowest)", "Alphabetical"];

class StatsView extends StatefulWidget {
  const StatsView({super.key});
  
  @override
  State<StatsView> createState() => StatsViewState();
}

class StatsViewState extends State<StatsView> {
  @override
  Widget build(BuildContext context) {
    // gather statistics
    int total = 0;
    int totalMissing = 0;
    int totalUngraded = 0;
    int totalGraded = 0;

    List<CourseStatDisplay> courseWidgets = List.empty(growable: true);

    for(Course c in CCache().cachedCourses) {
      total += c.totalAssignments;
      totalMissing += c.missingAssignments;
      totalUngraded += c.ungradedAssignments;
      totalGraded += c.gradedAssignments;

      courseWidgets.add(CourseStatDisplay(
        course: c,
        )
      );
    }

    return ListView(
      children: [
        Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Gap(15),
            const CallistoText("Welcome back,", size: 20, weight: FontWeight.bold),
            CallistoText(CCache().name, size: 35, weight: FontWeight.bold),
            CallistoText("Total: ${total}", size: 20),
            CallistoText("Missing: ${totalGraded}", size: 20),
            CallistoText("Ungraded: ${totalUngraded}", size: 20),
            CallistoText("Missing: ${totalMissing}", size: 20),
          ],
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: CallistoText("Sort by:", size: 10),
        ),
       SizedBox(
        width: 200,  // Set the width as per your requirements
        child: DropdownButton(
          // alignment: Alignment.centerLeft,
          underline: Container(
            height: 2,
            color: Colors.deepPurpleAccent,
          ),
          items: sortByLabels.map((String s) {
            return DropdownMenuItem(
              value: s,
              child: CallistoText(s, size: 10)
            );
          }).toList(),
          onChanged: (v) => print(v)
        ),
      ),
        ...courseWidgets
      ],
    );
  }
}

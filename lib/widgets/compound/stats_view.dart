import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/info_display/course_stat_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Course>>(
      future: CDbManager.getInstance().getCourses(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          ); 
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Course> courses = snapshot.data!;

          // gather statistics
          int total = 0;
          int totalMissing = 0;
          int totalUngraded = 0;
          int totalGraded = 0;

          List<CourseStatDisplay> courseWidgets = List.empty(growable: true);

          for(Course c in courses) {
            total += c.totalAssignments;
            totalMissing += c.missingAssignments;
            totalUngraded += c.ungradedAssignments;
            totalGraded += c.gradedAssignments;

            courseWidgets.add(CourseStatDisplay(
              courseName: c.name,
              courseInfo: c.placeAndTime,
              missing: c.missingAssignments,
              ungraded: c.ungradedAssignments,
              graded: c.gradedAssignments,
              total: c.totalAssignments,
              )
            );
          }

          return ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
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
              ...courseWidgets
            ],
          );
        }
      },
    );
  }
}

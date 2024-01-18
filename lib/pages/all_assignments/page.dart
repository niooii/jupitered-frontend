import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/pages/course/assignment_tile.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer.dart';
import 'package:jupiter_frontend/widgets/general/divider.dart';

class AllAssignmentsPage extends StatefulWidget {
  List<Course> allCourses;
  late List<Assignment> allAssignments = List.empty(growable: true);
  late List<Assignment> toRender = List.empty(growable: true);

  // stats
  int total = 0;
  int totalMissing = 0;
  int totalUngraded = 0;
  int totalGraded = 0;
  AllAssignmentsPage({super.key, required this.allCourses}) {

    for(Course c in allCourses) {
      total += c.totalAssignments;
      totalMissing += c.missingAssignments;
      totalUngraded += c.ungradedAssignments;
      totalGraded += c.gradedAssignments;

      allAssignments.addAll(c.assignments);
    }
    toRender.addAll(allAssignments);

    print(allAssignments);
  }

  @override
  State<AllAssignmentsPage> createState() => _AllAssignmentsPageState();
}

class _AllAssignmentsPageState extends State<AllAssignmentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CAppBar(title: "Assignments"),
      drawer: const CDrawer(),
      body: ListView(
        children: [
          const Gap(10),
          const CallistoText("Overall Statistics", size: 30, textAlign: TextAlign.center, weight: FontWeight.bold,),
          CallistoText("Total: ${widget.total}", size: 20, textAlign: TextAlign.center),
          CallistoText("Graded: ${widget.totalGraded}", size: 20, textAlign: TextAlign.center),
          CallistoText("Ungraded: ${widget.totalUngraded}", size: 20, textAlign: TextAlign.center),
          CallistoText("Missing: ${widget.totalMissing}", size: 20, textAlign: TextAlign.center),
          const CDivider(),
          CallistoText("Apply filters", size: 20, textAlign: TextAlign.center, weight: FontWeight.w600),
          // TODO! search bar here, filter by course and subsection of that will be filter by each courses category
          // aaron if u see this dw about it ill do it i feel like it sounds kinda retarded when i type it out
          const CDivider(),
          ...widget.toRender.map<Widget>((Assignment a) {
            return AssignmentTile(assignment: a, includeCourseName: true,);
          })
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/pages/course/assignment_tile.dart';
import 'package:jupiter_frontend/widgets/general/callisto_expandable_tile.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer.dart';
import 'package:jupiter_frontend/widgets/general/divider.dart';

class AssignmentsView extends StatefulWidget {
  bool multiCourse;
  late List<Assignment> assignments = List.empty(growable: true);
  late List<Assignment> toRender = List.empty(growable: true);

  // stats
  AssignmentsView({super.key, required this.assignments, this.multiCourse = false}) {

    toRender.addAll(assignments);

  }

  @override
  State<AssignmentsView> createState() => _AssignmentsViewState();
}

// TODO! if not multicourse, include category filter by searching through each assignments category.
// if it is multicourse, include "only show course: and then when button isn clicked, expand into each category with All in there too".
class _AssignmentsViewState extends State<AssignmentsView> {
  final TextEditingController _keywordSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: [
          CallistoText("Apply filters", size: 20, textAlign: TextAlign.center, weight: FontWeight.w600),
          Gap(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Filter by keyword',
              ),
              controller: _keywordSearchController,
              onChanged: (query) {
                setState(() {
                  if(query.isEmpty) {
                    widget.toRender = widget.assignments;
                  } else {
                    widget.toRender = widget.assignments.where((assignment) => assignment.name.toLowerCase().contains(query.toLowerCase())).toList();
                  }
                });
              },
            ),
          ),
          // TEST DELETE LATER 
          Row(
            children: [
              CExpansionTile(
                mainAxisAlignment: MainAxisAlignment.end,
                child: CallistoText("Test", size: 20),
                expandedChildren: [
                  CallistoText("aaa", size: 15),
                  CallistoText("bbb", size: 15),
                ],
                expandDirection: ExpandDirection.left,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.end,
          ),
          const CDivider(),
          ...widget.toRender.map<Widget>((Assignment a) {
            return AssignmentTile(assignment: a, includeCourseName: widget.multiCourse,);
          })
        ],
      );
  }
}
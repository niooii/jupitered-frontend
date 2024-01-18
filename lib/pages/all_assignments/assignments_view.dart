import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/pages/course/assignment_tile.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer.dart';
import 'package:jupiter_frontend/widgets/general/divider.dart';

class AssignmentsView extends StatefulWidget {
  late List<Assignment> assignments = List.empty(growable: true);
  late List<Assignment> toRender = List.empty(growable: true);

  // stats
  AssignmentsView({super.key, required this.assignments}) {

    toRender.addAll(assignments);

  }

  @override
  State<AssignmentsView> createState() => _AssignmentsViewState();
}

class _AssignmentsViewState extends State<AssignmentsView> {
  final TextEditingController _keywordSearchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return 
      Column(
        children: [
          CallistoText("Apply filters", size: 20, textAlign: TextAlign.center, weight: FontWeight.w600),
          Gap(10),
          // TODO! search bar here, filter by course and subsection of that will be filter by each courses category
          // aaron if u see this dw about it ill do it i feel like it sounds kinda retarded when i type it out
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
          const CDivider(),
          ...widget.toRender.map<Widget>((Assignment a) {
            return AssignmentTile(assignment: a, includeCourseName: true,);
          })
        ],
      );
  }
}
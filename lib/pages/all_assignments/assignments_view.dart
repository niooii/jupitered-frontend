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
  late List<Assignment> filteredFromSearch = List.empty(growable: true);
  late List<Assignment> toRender = List.empty(growable: true);

  late List<DropdownMenuItem<String>> categoryFilters;
  // stats
  AssignmentsView({super.key, required this.assignments, this.multiCourse = false}) {

    toRender.addAll(assignments);

    categoryFilters = assignments.map((assignment) {
      return DropdownMenuItem<String>(
        value: assignment.cat,
        child: Text(assignment.cat),
      );
    }).toList();

    categoryFilters.insert(
      0,
      const DropdownMenuItem<String>(
        value: null,
        child: Text("All"),
      ),
    );

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
    List<Widget> filterWidgets = List.empty(growable: true);

    filterWidgets.addAll([
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
                widget.filteredFromSearch = widget.assignments;
              } else {
                widget.filteredFromSearch = widget.assignments.where((assignment) => assignment.name.toLowerCase().contains(query.toLowerCase())).toList();
              }
            });
          },
        ),
      ),
    ]);

    if(widget.multiCourse) {

    } else {
      filterWidgets.add(
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  CallistoText("Show only: ", size: 20, weight: FontWeight.w400, textAlign: TextAlign.start),
                  DropdownButton(
                    items: widget.categoryFilters,
                    onChanged: (value) {
                      setState(() {
                        if(value == null) {
                          widget.toRender = widget.filteredFromSearch;
                        }
                        // TODO! FIX . 
                        widget.toRender = widget.toRender.where((assignment) => assignment.cat == value).toList();
                      });
                    }
                  )
                ],
              ),
            ],
          ),
        )
      );
      
    }

    return 
      Column(
        children: [
          ...filterWidgets,
          const CDivider(),
          ...widget.toRender.map<Widget>((Assignment a) {
            return AssignmentTile(assignment: a, includeCourseName: widget.multiCourse,);
          })
        ],
      );
  }
}
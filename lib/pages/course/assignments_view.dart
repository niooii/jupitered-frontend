import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/assignment.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/pages/course/assignment_tile.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';

// TODO! add filter by [Category]
// TODO! sort by grade.
class AssignmentsView extends StatefulWidget {
  final Course course;
  const AssignmentsView({super.key, required this.course});

  @override
  State<AssignmentsView> createState() => _AssignmentsViewState();
}

class _AssignmentsViewState extends State<AssignmentsView> {
  GradeCategory? _selectedCategory;

  List<AssignmentTile> assignmentWidgets = List.empty(growable: true);

  @override
  void initState() {
    assignmentWidgets.addAll(widget.course.assignments.map((Assignment a) {
      return AssignmentTile(assignment: a);
    }).toList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // create a list of assignment widgets

    // create the dropdown menu items
    List<DropdownMenuItem<GradeCategory>> filters =
        widget.course.gradeCategories
        .where((category) => category.category != "Course Average")
        .map((e) {
      return DropdownMenuItem<GradeCategory>(
        value: e,
        child: Text(e.toString()),
      );
    }).toList();

    // add the "All" option to the beginning of the list
    filters.insert(
      0,
      const DropdownMenuItem<GradeCategory>(
        value: null,
        child: Text("All"),
      ),
    );

    // sort the list of assignments by grad
    List<DropdownMenuItem<Function>> sorts = [
      DropdownMenuItem<Function>(
        value: sortGradeHigh,
        child: Text("Grade (Highest)"),
      ),
      DropdownMenuItem<Function>(
        value: sortGradeLow,
        child: Text("Grade (Lowest)"),
      ),
      DropdownMenuItem<Function>(
        value: sortRecentlyDue,
        child: Text("Recently Due"),
      ),
      DropdownMenuItem<Function>(
        value: sortLeastRecentlyDue,
        child: Text("Least Recently Due"),
      ),
    ];

    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        Column(
          children: [
            const CallistoText("Filter By:", size: 12.5, textAlign: TextAlign.left,),
            DropdownButton(
              items: filters,
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
              style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
        // const Gap(5),
        // Column(
        //   children: [
        //     const CallistoText("Sort By:", size: 12.5),
        //     DropdownButton(
        //         items: sorts,
        //         onChanged: (value) {
        //           setState(() {
        //             assignmentWidgets =
        //                 value!(assignmentWidgets.map((e) => e.assignment).toList());
        //           });
        //         }
        //       )
        //   ],
        // )
      ]
      ),
      // if an item is selected, filter the list of assignments
      if (_selectedCategory != null)
        ...assignmentWidgets
            .where((element) =>
                element.assignment.cat == _selectedCategory!.toString())
            .toList()
      else
        ...assignmentWidgets
    ]);
  }

  sortGradeHigh(List<Assignment> assignments) {
    assignments.sort((a, b) => (double.tryParse(a.score) ?? 0)
        .compareTo(double.tryParse(b.score) ?? 0));
    return assignments.map((e) => AssignmentTile(assignment: e)).toList();
  }

  sortGradeLow(List<Assignment> assignments) {
    assignments.sort((a, b) => (double.tryParse(b.score) ?? 0)
        .compareTo(double.tryParse(a.score) ?? 0));
    return assignments.map((e) => AssignmentTile(assignment: e)).toList();
  }

  sortRecentlyDue(List<Assignment> assignments) {
    assignments.sort((a, b) {
      if (a.duedate == null || b.duedate == null) return 0;
      return a.duedate!.compareTo(b.duedate!);
    });
    return assignments.map((e) => AssignmentTile(assignment: e)).toList();
  }

  sortLeastRecentlyDue(List<Assignment> assignments) {
    assignments.sort((a, b) {
      if (a.duedate == null || b.duedate == null) return 0;
      return b.duedate!.compareTo(a.duedate!);
    });

    return assignments.map((e) => AssignmentTile(assignment: e)).toList();
  }
}

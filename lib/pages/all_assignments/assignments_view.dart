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

class SortOption {
  final String label;
  final Function sortingFunction;

  SortOption(this.label, this.sortingFunction);

  @override
  String toString() {
    return label;
  }
}

class AssignmentsView extends StatefulWidget {
  bool multiCourse;
  late List<Assignment> assignments = List.empty(growable: true);
  late List<Assignment> filteredFromSearch = List.empty(growable: true);
  late List<Assignment> toRender = List.empty(growable: true);

  late List<DropdownMenuItem<String>> categoryFilters;
  // stats
  AssignmentsView({super.key, required this.assignments, this.multiCourse = false}) {

    filteredFromSearch.addAll(assignments);
    toRender.addAll(filteredFromSearch);

    // TODO! TEST LATER
    categoryFilters = assignments.map((a) {
      return a.cat;
    }).toSet().map((category) {
      return DropdownMenuItem<String>(
        value: category,
        child: Text(category),
      );
    }).toList();

    categoryFilters.insert(
      0,
      const DropdownMenuItem<String>(
        value: "All",
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
  String categoryFilter = "All";
  late List<DropdownMenuItem<SortOption>> sorts;
  late SortOption sortBy;

  // TJANK YOU AARON
  // TODO! do these too oops
  sortGradeHigh(List<Assignment> assignments) {
    assignments.sort((a, b) {
      return b.percentScore.compareTo(a.percentScore);
    });
  }

  sortGradeLow(List<Assignment> assignments) {
    assignments.sort((a, b) {
      // hardcoding ungraded assignments to not show
      if (a.status == AssignmentStatus.ungraded) return 200;
      return a.percentScore.compareTo(b.percentScore);
    });
  }

  sortWeightLow(List<Assignment> assignments) {
    assignments.sort((a, b) {
      return a.weight.compareTo(b.weight);
    });
  }

  sortWeightHeigh(List<Assignment> assignments) {
    assignments.sort((a, b) {
      return b.weight.compareTo(a.weight);
    });
  }

  sortRecentlyDue(List<Assignment> assignments) {
    assignments.sort((a, b) {
      if (a.duedate == null || b.duedate == null) return 0;
        return b.duedate!.compareTo(a.duedate!);
    });
  }

  sortLeastRecentlyDue(List<Assignment> assignments) {
    assignments.sort((a, b) {
      if (a.duedate == null || b.duedate == null) return 0;
        return a.duedate!.compareTo(b.duedate!);
    });
  }

  @override
  void initState() {
    sorts = [
      DropdownMenuItem<SortOption>(
        value: SortOption("Recent", sortRecentlyDue),
        child: const Text("Recent"),
      ),
      DropdownMenuItem<SortOption>(
        value: SortOption("Oldest", sortLeastRecentlyDue),
        child: const Text("Oldest"),
      ),
      DropdownMenuItem<SortOption>(
        value: SortOption("Grade (Highest)", sortGradeHigh),
        child: const Text("Grade (Highest)"),
      ),
      DropdownMenuItem<SortOption>(
        value: SortOption("Grade (Lowest)", sortGradeLow),
        child: const Text("Grade (Lowest)"),
      ),
      DropdownMenuItem<SortOption>(
        value: SortOption("Weight (Highest)", sortWeightHeigh),
        child: const Text("Weight (Highest)"),
      ),
      DropdownMenuItem<SortOption>(
        value: SortOption("Weight (Lowest)", sortWeightLow),
        child: const Text("Weight (Lowest)"),
      ),
    ];

    sortBy = sorts[0].value!;

    // default is by most recent
    sortBy.sortingFunction(widget.assignments);
    setState(() {
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> filterWidgets = List.empty(growable: true);

    filterWidgets.addAll([
      // CallistoText("Apply filters", size: 20, textAlign: TextAlign.center, weight: FontWeight.w600),
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

              if(categoryFilter == "All") {
                widget.toRender = widget.filteredFromSearch;
              } else {
                widget.toRender = widget.filteredFromSearch.where((assignment) => assignment.cat == categoryFilter).toList();
              }

              

              // run sorting thing again
              sortBy.sortingFunction(widget.toRender);
            });
          },
        ),
      ),
    ]);

    if(widget.multiCourse) {
      // TODO! show only [course]
      //i dont think i have time for this LOL
    } else {
      filterWidgets.add(
        Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              const CallistoText("Show only: ", size: 17, weight: FontWeight.w400, textAlign: TextAlign.start),
              const Gap(10),
              DropdownButton(
                focusColor: Colors.transparent,
                value: categoryFilter,
                items: widget.categoryFilters,
                onChanged: (value) {
                  setState(() {
                    categoryFilter = value!;

                    if(categoryFilter == "All") {
                      widget.toRender = widget.filteredFromSearch;
                    } else {
                      widget.toRender = widget.filteredFromSearch.where((assignment) => assignment.cat == categoryFilter).toList();
                    }

                    // run sorting thing again
                    sortBy.sortingFunction(widget.toRender);
                  });
                }
              )
            ],
          ),
        )
      ); 
    }

    // works for both all assignments and one course page
    filterWidgets.add(
      Padding(
        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
        child: Row(
          children: [
            const CallistoText("Sort by: ", size: 17, weight: FontWeight.w400, textAlign: TextAlign.start),
            const Gap(10),
            DropdownButton<SortOption>(
              focusColor: Colors.transparent,
              value: sortBy,
              items: sorts,
              onChanged: (value) {
                setState(() {
                  sortBy = value!;
                  value.sortingFunction(widget.toRender);
                });
              }
            )
          ],
        ),
      )
    );

    return 
      Column(
        children: [
          ...filterWidgets,
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CallistoText("Displaying ${widget.toRender.length}/${widget.assignments.length} assignment(s)", size: 10, weight: FontWeight.w500 ),
              ],
            ),
          ),
          const CDivider(),
          ...widget.toRender.map<Widget>((Assignment a) {
            return AssignmentTile(assignment: a, includeCourseName: widget.multiCourse,);
          })
        ],
      );
  }
}
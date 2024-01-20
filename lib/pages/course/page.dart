import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/pages/all_assignments/assignments_view.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/general/divider.dart';

class CoursePage extends StatelessWidget {
  final Course course;
  const CoursePage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: CAppBar(title: course.name),
      body: ListView(
        children: [
          // TODO!
          // display grade category info here
          ...course.gradeCategories.map<Widget>((category) {
            if (category.category == "Course Average") {
              return Padding(
                padding: EdgeInsets.all(15),
                child: Center(
                    child: FittedBox(
                  child: CallistoText(
                    "Course average: ${category.percentGrade == null ? "N/A" : "${category.percentGrade}%"}",
                    size: 30,
                    weight: FontWeight.w600,
                  ),
                )),
              );
            }
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CallistoText(
                      "${category.category}: ",
                      size: 18,
                      weight: FontWeight.w500,
                    ),
                    CallistoText(
                        "${category.percentGrade ?? "N/A"} ${category.fractionGrade == null ? "(${category.fractionGrade})" : ""}",
                        size: 18),
                  ],
                ),
                CallistoText(
                  "${category.additionalInfo}",
                  size: 15,
                  weight: FontWeight.w200,
                ),
                Gap(10),
              ],
            );
          }),
          CDivider(),
          AssignmentsView(assignments: course.assignments)
        ],
      ),
    ));
  }
}

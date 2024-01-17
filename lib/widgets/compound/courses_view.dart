import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/info_display/course_tile.dart';

const List<String> sortByLabels = ["Grade (Highest)", "Grade (Lowest)", "Alphabetical"];

class CoursesView extends StatefulWidget {
  const CoursesView({super.key});
  
  @override
  State<CoursesView> createState() => CoursesViewState();
}

class CoursesViewState extends State<CoursesView> {
  @override
  Widget build(BuildContext context) {
    List<CourseTile> courseWidgets = List.empty(growable: true);

    for(Course c in CCache().cachedCourses) {
      courseWidgets.add(CourseTile(
        course: c,
        )
      );
    }

    return Column(
      children: [
      //   Padding(
      //     padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
      //     child: CallistoText("Sort by:", size: 10),
      //   ),
      //  SizedBox(
      //   width: 200,  // Set the width as per your requirements
      //   child: DropdownButton(
      //     // alignment: Alignment.centerLeft,
      //     underline: Container(
      //       height: 2,
      //       color: Colors.deepPurpleAccent,
      //     ),
      //     items: sortByLabels.map((String s) {
      //       return DropdownMenuItem(
      //         value: s,
      //         child: CallistoText(s, size: 10)
      //       );
      //     }).toList(),
      //     onChanged: (v) => print(v)
      //   ),
      // ),
        ...courseWidgets
      ],
    );
  }
}

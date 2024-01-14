import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/widgets/assigment.dart';
import 'package:jupiter_frontend/widgets/drawer.dart';

class CourseDetails extends StatefulWidget {
  CourseDetails(this.course, {super.key});
  Course course;
  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text(widget.course.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          Text(widget.course.name),
          Text(widget.course.teacher),
          Text(widget.course.getGrade().toString() + "%"),
          Expanded(
            child: ListView.builder(
              itemCount: widget.course.assignments.length,
              itemBuilder: (context, index) {
                return AssignmentTile(
                    assignment: widget.course.assignments[index]);
              },
            ),
          ),
        ],
      ),
    ));
  }
}

class CourseTile extends StatefulWidget {
  CourseTile(this.course, {super.key});
  Course course;
  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.course.name),
      subtitle: Text(widget.course.teacher),
      trailing: Text(widget.course.getGrade().toString() + "%"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CourseDetails(widget.course)),
        );
      },
    );
  }
}

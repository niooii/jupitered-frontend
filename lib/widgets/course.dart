import 'package:flutter/material.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/widgets/assigment.dart';
import 'package:jupiter_frontend/widgets/callisto_drawer.dart';

class CourseDetails extends StatefulWidget {
  CourseDetails(this.course, {Key? key}) : super(key: key);

  final Course course;

  @override
  State<CourseDetails> createState() => _CourseDetailsState();
}

class _CourseDetailsState extends State<CourseDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.course.name,
            style:
                TextStyle(color: Theme.of(context).colorScheme.onPrimary),
          ),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: Column(
          children: [
            Text(widget.course.name),
            Text(widget.course.teacher),
            Text("${widget.course.ave.toString()}%"),
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
      ),
    );
  }
}

class CourseTile extends StatefulWidget {
  CourseTile(this.course, {Key? key}) : super(key: key);

  final Course course;

  @override
  State<CourseTile> createState() => _CourseTileState();
}

class _CourseTileState extends State<CourseTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.course.name),
      subtitle: Text(widget.course.teacher),
      trailing: Text("${widget.course.ave.toString()}%"),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetails(widget.course),
          ),
        );
      },
    );
  }
}

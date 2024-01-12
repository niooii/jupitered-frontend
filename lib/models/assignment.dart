class Assignment {
  String name;
  DateTime duedate;

  double grade;
  double maxGrade;

  double impact;

  String cat;

  Assignment(this.name, this.duedate, this.grade, this.maxGrade, this.impact,
      this.cat);

  double getPercent() {
    return grade / maxGrade;
  }

  String getFractionalGrade() {
    return grade.toString() + "/" + maxGrade.toString();
  }
}

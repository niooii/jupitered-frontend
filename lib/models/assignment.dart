class Assignment {
  String name;
  DateTime duedate;

  double grade;
  double maxGrade;

  double impact;

  String cat;
  double weight;

  Assignment(this.name, this.duedate, this.grade, this.maxGrade, this.impact,
      this.cat, this.weight);

  double getPercent() {
    return grade / maxGrade;
  }

  String getFractionalGrade() {
    return grade.toString() + "/" + maxGrade.toString();
  }

  double getWeightedGrade() {
    return grade * weight;
  }
}

class Assignment {
  String name;
  DateTime? duedate;

  double? grade;
  double maxGrade;

  double impact;

  String cat;
  double weight;

  Assignment(this.name, this.duedate, this.grade, this.maxGrade, this.impact,
      this.cat, this.weight);

  factory Assignment.fromMap(Map<String, dynamic> map) {
    return Assignment(
        map["name"],
        DateTime.tryParse(map["date_due"]) ?? DateTime.now(),
        double.tryParse(map["score"]) ?? 0,
        double.tryParse(map["worth"] ?? "0") ?? 0,
        double.tryParse(map["impact"]) ?? 0,
        map["category"],
        double.parse(map["weight"] ?? "0"));
  }

  // {
  // 	"name": "Midyear Project (Source Code and Video)",
  // 	"date_due": "1/7",
  // 	"score": "/100",
  // 	"worth": 100,
  // 	"impact": "",
  // 	"category": "Midyear/Final"
  // },

  double getPercent() {
    return grade ?? 0 / maxGrade;
  }

  String getFractionalGrade() {
    return grade.toString() + "/" + maxGrade.toString();
  }

  double getWeightedGrade() {
    return grade ?? 0 * weight;
  }
}

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
        parseDate(map["date_due"]),
        parseScore(map["score"]),
        parseMaxScore(map["score"]),
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
  static double parseMaxScore(String score) {
    if (score == "absent") {
      return 0;
    }
    if (score == "zero") {
      return 0;
    }
    return double.parse(score.split("/")[1]);
  }

  static double parseScore(String score) {
    if (score == "absent") {
      return 0;
    }
    if (score == "zero") {
      return 0;
    }
    return double.tryParse(score.split("/")[0]) ?? 0;
  }

  static DateTime parseDate(String dd) {
    var da = dd.split("/");
    // print(da);
    // print(da.length);
    if (da.length != 2) {
      return DateTime.now();
    }
    if (da[1].contains("-")) {
      da[1] = da[1].split("-")[0];
    }
    // print("we made it pass the guard case boys");
    int month = int.parse(da[0]);
    int day = int.parse(da[1]);
    int year;

    if (DateTime.now().month > 9) {
      if (month < 9) {
        year = DateTime.now().year + 1;
      } else {
        year = DateTime.now().year;
      }
    } else {
      if (month > 9) {
        year = DateTime.now().year - 1;
      } else {
        year = DateTime.now().year;
      }
    }
    return DateTime(year, month, day);
  }

  double getPercent() {
    // print(
    // "grade: $grade, maxGrade: $maxGrade = ${((grade ?? 0) / maxGrade) * 100}");
    return ((grade ?? 0) / maxGrade) * 100;
  }

  String getFractionalGrade() {
    return grade.toString() + "/" + maxGrade.toString();
  }

  double getWeightedGrade() {
    return (grade ?? 0) * weight;
  }
}

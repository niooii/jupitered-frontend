// Try to fetch data as little as possible. I/O operation are expensive AS FUCK

import '../models/course.dart';

class CallistoCache {
  static CallistoCache? _instance;
  late String osis;
  late String name;
  late List<Course> cachedCourses;

  CallistoCache._();

  factory CallistoCache() {
    _instance ??= CallistoCache._();
    return _instance!;
  }

  void cacheCourses(List<Course> courses) {
    cachedCourses = courses;
  }

  void cacheOsis(String osis) {
    this.osis = osis;
  }

  void cacheName(String name) {
    this.name = name;
  }

}
// Try to fetch data as little as possible. I/O operation are expensive AS FUCK

import '../models/course.dart';

class CCache {
  static CCache? _instance;
  late String osis;
  late String name;
  late List<Course> cachedCourses;

  CCache._();

  factory CCache() {
    _instance ??= CCache._();
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
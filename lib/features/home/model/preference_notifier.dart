import 'package:flutter/material.dart';

class PreferenceModel extends ChangeNotifier {
  int? degreeId;
  int? facultyId;
  int? subjectId;
  int? selectedYear;
  int? selectedSemester;
  int? selectedCategory;

  void clearState() {
    degreeId = null;
    facultyId = null;
    subjectId = null;
    selectedYear = null;
    selectedSemester = null;
    selectedCategory = null;
    notifyListeners();
  }

  void updateSelectedDegreeId(int? id) {
    degreeId = id;
    notifyListeners();
  }

  void updateSelectedSubjectId(int? id) {
    subjectId = id;
    notifyListeners();
  }

  void updateSelectedFacultyId(int? id) {
    facultyId = id;
    notifyListeners();
  }

  void updateSelectedYear(int? year) {
    selectedYear = year;
    notifyListeners();
  }

  void updateSelectedSemester(int? semester) {
    selectedSemester = semester;
    notifyListeners();
  }

  void updateSelectedCategory(int? category) {
    selectedCategory = category;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

class PreferenceModel extends ChangeNotifier {
  String? selectedDegree;
  String? selectedSubject;
  String? selectedFaculty;
  int? selectedYear;
  int? selectedSemester;

  void updateSelectedDegree(String? degree) {
    selectedDegree = degree;
    notifyListeners();
  }

  void updateSelectedSubject(String? subject) {
    selectedSubject = subject;
    notifyListeners();
  }

  void updateSelectedFaculty(String? Faculty) {
    selectedFaculty = Faculty;
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
}

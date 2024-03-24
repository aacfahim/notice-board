import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:notice_board/features/home/model/degree_model.dart';
import 'package:notice_board/features/home/model/preference_notifier.dart';
import 'package:notice_board/features/home/repos/preferred_degree_dropdown.dart';
import 'package:provider/provider.dart';

class ShowDialoguePreferrence extends StatefulWidget {
  const ShowDialoguePreferrence({Key? key}) : super(key: key);

  @override
  State<ShowDialoguePreferrence> createState() =>
      _ShowDialoguePreferrenceState();
}

class _ShowDialoguePreferrenceState extends State<ShowDialoguePreferrence> {
  List<DegreeModel> _degreeDropdownData = [];
  String? _selectedDegree;
  String? _selectedSubject;
  String? _selectedFaculty;
  int? _selectedYear;
  int? _selectedSemester;

  @override
  void initState() {
    super.initState();
    _fetchDegreeDropdown();
  }

  Future<void> _fetchDegreeDropdown() async {
    List<DegreeModel> degreeList = await PreferredDegree.fetchDegreeDropdown();
    setState(() {
      _degreeDropdownData = degreeList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButton<String>(
            hint: Text('Select Degree'),
            value: _selectedDegree,
            onChanged: (String? value) {
              setState(() {
                _selectedDegree = value;
                _selectedSubject = null;
                _selectedFaculty = null;
                _selectedYear = null;
                _selectedSemester = null;
              });
              int? degreeId = _degreeDropdownData
                  .firstWhereOrNull((degree) => degree.degreeName == value)
                  ?.degreeId;
              Provider.of<PreferenceModel>(context, listen: false)
                  .updateSelectedDegreeId(degreeId);
            },
            items: _degreeDropdownData
                .where((degree) => degree.degreeName != null)
                .map((degree) => degree.degreeName!)
                .toSet()
                .map((degreeName) {
              return DropdownMenuItem<String>(
                value: degreeName,
                child: Text(degreeName),
              );
            }).toList(),
          ),
          if (_selectedDegree != null)
            if (_degreeHasSubject(_selectedDegree))
              DropdownButton<String>(
                isExpanded: true,
                hint: Text('Select Subject'),
                value: _selectedSubject,
                onChanged: _handleSubjectChange,
                items: _getSubjectItems(),
              ),
          if (_selectedDegree != null)
            if (_degreeHasFaculty(_selectedDegree))
              DropdownButton<String>(
                isExpanded: true,
                hint: Text('Select Faculty'),
                value: _selectedFaculty,
                onChanged: _handleFacultyChange,
                items: _getFacultyItems(),
              ),
          if (_selectedDegree != null)
            DropdownButton<int>(
              hint: Text('Select Year'),
              value: _selectedYear,
              onChanged: (int? value) {
                setState(() {
                  _selectedYear = value;
                  _selectedSemester = null;
                });
                Provider.of<PreferenceModel>(context, listen: false)
                    .updateSelectedYear(value);
              },
              items: _getYearItems(),
            ),
          if (_selectedYear != null && _degreeHasSemesters(_selectedDegree))
            DropdownButton<int>(
              hint: Text('Select Semester'),
              value: _selectedSemester,
              onChanged: (int? value) {
                setState(() {
                  _selectedSemester = value;
                });
                Provider.of<PreferenceModel>(context, listen: false)
                    .updateSelectedSemester(value);
              },
              items: _getSemesterItems(),
            ),
        ],
      ),
    );
  }

  List<DropdownMenuItem<String>> _getSubjectItems() {
    if (_selectedDegree == null) return [];
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == _selectedDegree);
    if (selectedDegreeData != null && selectedDegreeData.subjectName != null) {
      return _degreeDropdownData
          .where((degree) =>
              degree.degreeName == _selectedDegree &&
              degree.subjectName != null)
          .map((degree) => degree.subjectName!)
          .toSet()
          .map((subjectName) {
        return DropdownMenuItem<String>(
          value: subjectName,
          child: Text(subjectName),
        );
      }).toList();
    }
    return [];
  }

  List<DropdownMenuItem<String>> _getFacultyItems() {
    if (_selectedDegree == null) return [];
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == _selectedDegree);
    if (selectedDegreeData != null && selectedDegreeData.facultyName != null) {
      return _degreeDropdownData
          .where((degree) =>
              degree.degreeName == _selectedDegree &&
              degree.facultyName != null)
          .map((degree) => degree.facultyName!)
          .toSet()
          .map((facultyName) {
        return DropdownMenuItem<String>(
          value: facultyName,
          child: Text(facultyName),
        );
      }).toList();
    }
    return [];
  }

  List<DropdownMenuItem<int>> _getYearItems() {
    if (_selectedDegree == null) return [];
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == _selectedDegree);
    if (selectedDegreeData != null) {
      return List.generate(
        selectedDegreeData.durationYears,
        (index) {
          int yearValue = index + 1;
          String yearLabel = _getYearLabel(yearValue);
          return DropdownMenuItem<int>(
            value: yearValue,
            child: Text(yearLabel),
          );
        },
      ).toList();
    }
    return [];
  }

  String _getYearLabel(int yearValue) {
    switch (yearValue) {
      case 1:
        return 'First Year';
      case 2:
        return 'Second Year';
      case 3:
        return 'Third Year';
      case 4:
        return 'Fourth Year';
      case 5:
        return 'Fifth Year';
      default:
        return 'Year $yearValue'; // Fallback if more than 5 years
    }
  }

  String getSuffix(int number) {
    if (number >= 11 && number <= 13) {
      return 'th';
    }
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }

  List<DropdownMenuItem<int>> _getSemesterItems() {
    if (_selectedYear == null) return [];

    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == _selectedDegree);

    if (selectedDegreeData != null &&
        selectedDegreeData.durationSemesters != null) {
      List<DropdownMenuItem<int>> items = [];
      int totalSemesters = selectedDegreeData.durationSemesters!;
      int startingSemester = (_selectedYear! - 1) * 2 + 1;
      int endingSemester = startingSemester + 1;

      for (int i = startingSemester;
          i <= totalSemesters && i <= endingSemester;
          i++) {
        String suffix = getSuffix(i);
        String semesterText = '$i$suffix Semester';

        items.add(
          DropdownMenuItem<int>(
            value: i,
            child: Text(semesterText),
          ),
        );
      }
      return items;
    }
    return [];
  }

  bool _degreeHasSubject(String? degreeName) {
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == degreeName);
    return selectedDegreeData?.subjectName != null;
  }

  bool _degreeHasFaculty(String? degreeName) {
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == degreeName);
    return selectedDegreeData?.facultyName != null;
  }

  bool _degreeHasSemesters(String? degreeName) {
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == degreeName);
    return selectedDegreeData?.durationSemesters != null;
  }

  void _handleSubjectChange(String? value) {
    setState(() {
      _selectedSubject = value;
      _selectedFaculty = null;
      _selectedYear = null;
      _selectedSemester = null;
    });
    if (value != null) {
      int? subjectId = _degreeDropdownData
          .firstWhereOrNull((degree) => degree.subjectName == value)
          ?.subjectId;
      Provider.of<PreferenceModel>(context, listen: false)
          .updateSelectedSubjectId(subjectId);
    }
  }

  void _handleFacultyChange(String? value) {
    setState(() {
      _selectedFaculty = value;
      _selectedSubject = null;
      _selectedYear = null;
      _selectedSemester = null;
    });
    if (value != null) {
      int? facultyId = _degreeDropdownData
          .firstWhereOrNull((degree) => degree.facultyName == value)
          ?.facultyId;
      Provider.of<PreferenceModel>(context, listen: false)
          .updateSelectedFacultyId(facultyId);
    }
  }
}

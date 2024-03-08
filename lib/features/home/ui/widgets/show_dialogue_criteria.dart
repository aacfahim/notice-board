import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:notice_board/features/home/model/degree_model.dart';
import 'package:notice_board/features/home/repos/preferred_degree_dropdown.dart';

class ShowDialoguePreferrence extends StatefulWidget {
  const ShowDialoguePreferrence({Key? key}) : super(key: key);

  @override
  State<ShowDialoguePreferrence> createState() =>
      _ShowDialoguePreferrenceState();
}

class _ShowDialoguePreferrenceState extends State<ShowDialoguePreferrence> {
  List<DegreeModel> _degreeDropdownData = [];
  String? _selectedDegree;
  String? _selectedSubjectOrFaculty;
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
    return Column(
      children: [
        DropdownButton<String>(
          hint: Text('Select Degree'),
          value: _selectedDegree,
          onChanged: (String? value) {
            setState(() {
              _selectedDegree = value;
              _selectedSubjectOrFaculty = null;
              _selectedYear = null;
              _selectedSemester = null;
            });
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
          DropdownButton<String>(
            hint: Text('Select ${_getSubjectOrFacultyLabel()}'),
            value: _selectedSubjectOrFaculty,
            onChanged: (String? value) {
              setState(() {
                _selectedSubjectOrFaculty = value;
                _selectedYear = null;
                _selectedSemester = null;
              });
            },
            items: _getSubjectOrFacultyItems(),
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
            },
            items: _getYearItems(),
          ),
        if (_selectedYear != null)
          DropdownButton<int>(
            hint: Text('Select Semester'),
            value: _selectedSemester,
            onChanged: (int? value) {
              setState(() {
                _selectedSemester = value;
              });
            },
            items: _getSemesterItems(),
          ),
      ],
    );
  }

  String _getSubjectOrFacultyLabel() {
    if (_selectedDegree == null) return '';
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == _selectedDegree);
    if (selectedDegreeData != null) {
      if (selectedDegreeData.subjectName != null) return 'Subject';
      if (selectedDegreeData.facultyName != null) return 'Faculty';
    }
    return '';
  }

  List<DropdownMenuItem<String>> _getSubjectOrFacultyItems() {
    if (_selectedDegree == null) return [];
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == _selectedDegree);
    if (selectedDegreeData != null) {
      if (selectedDegreeData.subjectName != null) {
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
      } else if (selectedDegreeData.facultyName != null) {
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
        (index) => index + 1,
      ).map((year) {
        return DropdownMenuItem<int>(
          value: year,
          child: Text('$year'),
        );
      }).toList();
    }
    return [];
  }

  List<DropdownMenuItem<int>> _getSemesterItems() {
    if (_selectedYear == null) return [];
    final selectedDegreeData = _degreeDropdownData
        .firstWhereOrNull((degree) => degree.degreeName == _selectedDegree);
    if (selectedDegreeData != null &&
        selectedDegreeData.durationSemesters != null) {
      int startingSemester = (_selectedYear! - 1) * 2 + 1;
      return [
        DropdownMenuItem<int>(
          value: startingSemester,
          child: Text('$startingSemester'),
        ),
        DropdownMenuItem<int>(
          value: startingSemester + 1,
          child: Text('${startingSemester + 1}'),
        ),
      ];
    }
    return [];
  }
}

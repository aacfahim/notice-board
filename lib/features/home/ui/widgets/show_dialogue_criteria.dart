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
                onChanged: (String? value) {
                  setState(() {
                    _selectedSubject = value;
                    _selectedFaculty = null;
                    _selectedYear = null;
                    _selectedSemester = null;
                  });
                  int? subjectId = _degreeDropdownData
                      .firstWhereOrNull((degree) => degree.subjectName == value)
                      ?.subjectId;
                  Provider.of<PreferenceModel>(context, listen: false)
                      .updateSelectedSubjectId(subjectId);
                },
                items: _getSubjectItems(),
              ),
          if (_selectedDegree != null)
            if (_degreeHasFaculty(_selectedDegree))
              DropdownButton<String>(
                isExpanded: true,
                hint: Text('Select Faculty'),
                value: _selectedFaculty,
                onChanged: (String? value) {
                  setState(() {
                    _selectedFaculty = value;
                    _selectedSubject = null;
                    _selectedYear = null;
                    _selectedSemester = null;
                  });

                  int? facultyId = _degreeDropdownData
                      .firstWhereOrNull((degree) => degree.facultyName == value)
                      ?.facultyId;
                  Provider.of<PreferenceModel>(context, listen: false)
                      .updateSelectedFacultyId(facultyId);
                },
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
}

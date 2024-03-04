class DegreeModel {
  int durationYears;
  int? durationSemesters;
  String? degreeName;
  String? facultyName;
  String? subjectName;

  DegreeModel({
    required this.durationYears,
    this.durationSemesters,
    this.degreeName,
    this.facultyName,
    this.subjectName,
  });

  factory DegreeModel.fromJson(Map<String, dynamic> json) {
    return DegreeModel(
      durationYears: json['attributes']['duration_years'] ?? 0,
      durationSemesters: json['attributes']['duration_semesters'],
      degreeName: json['attributes']['degree'] != null &&
              json['attributes']['degree']['data'] != null
          ? json['attributes']['degree']['data']['attributes']['degree_name']
          : null,
      facultyName: json['attributes']['faculty'] != null &&
              json['attributes']['faculty']['data'] != null
          ? json['attributes']['faculty']['data']['attributes']['faculty_name']
          : null,
      subjectName: json['attributes']['subject'] != null &&
              json['attributes']['subject']['data'] != null
          ? json['attributes']['subject']['data']['attributes']['subject_name']
          : null,
    );
  }
}

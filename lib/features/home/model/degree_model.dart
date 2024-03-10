class DegreeModel {
  int durationYears;
  int? durationSemesters;
  String? degreeName;
  String? facultyName;
  String? subjectName;
  int? degreeId;
  int? facultyId;
  int? subjectId;

  DegreeModel({
    required this.durationYears,
    this.durationSemesters,
    this.degreeName,
    this.facultyName,
    this.subjectName,
    this.degreeId,
    this.facultyId,
    this.subjectId,
  });

  factory DegreeModel.fromJson(Map<String, dynamic> json) {
    return DegreeModel(
      durationYears: json['attributes']['duration_years'] ?? 0,
      durationSemesters: json['attributes']['duration_semesters'],
      degreeName: json['attributes']['degree'] != null &&
              json['attributes']['degree']['data'] != null
          ? json['attributes']['degree']['data']['attributes']['degree_name']
          : null,
      degreeId: json['attributes']['degree'] != null &&
              json['attributes']['degree']['data'] != null
          ? json['attributes']['degree']['data']['id']
          : null,
      facultyName: json['attributes']['faculty'] != null &&
              json['attributes']['faculty']['data'] != null
          ? json['attributes']['faculty']['data']['attributes']['faculty_name']
          : null,
      facultyId: json['attributes']['faculty'] != null &&
              json['attributes']['faculty']['data'] != null
          ? json['attributes']['faculty']['data']['id']
          : json['attributes']['faculty'] != null
              ? json['attributes']['faculty']['data']
              : null,
      subjectName: json['attributes']['subject'] != null &&
              json['attributes']['subject']['data'] != null
          ? json['attributes']['subject']['data']['attributes']['subject_name']
          : null,
      subjectId: json['attributes']['subject'] != null &&
              json['attributes']['subject']['data'] != null
          ? json['attributes']['subject']['data']['id']
          : null,
    );
  }
}

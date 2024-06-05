class TutorListModel {
  List<TutorDataModel>? data;

  TutorListModel({this.data});

  TutorListModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TutorDataModel>[];
      json['data'].forEach((v) {
        data!.add(new TutorDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TutorDataModel {
  int? id;
  Attributes? attributes;

  TutorDataModel({this.id, this.attributes});

  TutorDataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? tutorName;
  String? subjectSkill;
  String? location;
  String? contact;
  String? startFrom;
  int? duration;
  String? ratings;
  String? tutorEmail;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? oid;

  Attributes(
      {this.tutorName,
      this.subjectSkill,
      this.location,
      this.contact,
      this.startFrom,
      this.duration,
      this.ratings,
      this.tutorEmail,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.oid});

  Attributes.fromJson(Map<String, dynamic> json) {
    tutorName = json['tutor_name'];
    subjectSkill = json['subject_skill'];
    location = json['location'];
    contact = json['contact'];
    startFrom = json['start_from'];
    duration = json['duration'];
    ratings = json['ratings'];
    tutorEmail = json['tutor_email'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    oid = json['oid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tutor_name'] = this.tutorName;
    data['subject_skill'] = this.subjectSkill;
    data['location'] = this.location;
    data['contact'] = this.contact;
    data['start_from'] = this.startFrom;
    data['duration'] = this.duration;
    data['ratings'] = this.ratings;
    data['tutor_email'] = this.tutorEmail;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['oid'] = this.oid;
    return data;
  }
}

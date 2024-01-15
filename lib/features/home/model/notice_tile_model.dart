class NoticeModel {
  List<NoticeDataModel>? data;
  Meta? meta;

  NoticeModel({this.data, this.meta});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NoticeDataModel>[];
      json['data'].forEach((v) {
        data!.add(new NoticeDataModel.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta!.toJson();
    }
    return data;
  }
}

class NoticeDataModel {
  int? id;
  Attributes? attributes;

  NoticeDataModel({this.id, this.attributes});

  NoticeDataModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? publicationDate;
  String? dateInNotice;
  String? nuNoticePdfLink;
  String? nuNoticeId;
  String? pedTitle;
  int? pages;
  String? innerTitle;
  String? signedByName;
  String? signedByDesignation;
  String? signedByPhone;
  String? signedByEmail;
  String? signedByName2;
  String? signedByDesignation2;
  String? signedByPhone2;
  Null? signedByEmail2;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;

  Attributes(
      {this.title,
      this.publicationDate,
      this.dateInNotice,
      this.nuNoticePdfLink,
      this.nuNoticeId,
      this.pedTitle,
      this.pages,
      this.innerTitle,
      this.signedByName,
      this.signedByDesignation,
      this.signedByPhone,
      this.signedByEmail,
      this.signedByName2,
      this.signedByDesignation2,
      this.signedByPhone2,
      this.signedByEmail2,
      this.createdAt,
      this.updatedAt,
      this.publishedAt});

  Attributes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    publicationDate = json['publication_date'];
    dateInNotice = json['date_in_notice'];
    nuNoticePdfLink = json['nu_notice_pdf_link'];
    nuNoticeId = json['nu_notice_id'];
    pedTitle = json['ped_title'];
    pages = json['pages'];
    innerTitle = json['inner_title'];
    signedByName = json['signed_by_name'];
    signedByDesignation = json['signed_by_designation'];
    signedByPhone = json['signed_by_phone'];
    signedByEmail = json['signed_by_email'];
    signedByName2 = json['signed_by_name_2'];
    signedByDesignation2 = json['signed_by_designation_2'];
    signedByPhone2 = json['signed_by_phone_2'];
    signedByEmail2 = json['signed_by_email_2'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['publication_date'] = this.publicationDate;
    data['date_in_notice'] = this.dateInNotice;
    data['nu_notice_pdf_link'] = this.nuNoticePdfLink;
    data['nu_notice_id'] = this.nuNoticeId;
    data['ped_title'] = this.pedTitle;
    data['pages'] = this.pages;
    data['inner_title'] = this.innerTitle;
    data['signed_by_name'] = this.signedByName;
    data['signed_by_designation'] = this.signedByDesignation;
    data['signed_by_phone'] = this.signedByPhone;
    data['signed_by_email'] = this.signedByEmail;
    data['signed_by_name_2'] = this.signedByName2;
    data['signed_by_designation_2'] = this.signedByDesignation2;
    data['signed_by_phone_2'] = this.signedByPhone2;
    data['signed_by_email_2'] = this.signedByEmail2;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    return data;
  }
}

class Meta {
  Pagination? pagination;

  Meta({this.pagination});

  Meta.fromJson(Map<String, dynamic> json) {
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Pagination {
  int? page;
  int? pageSize;
  int? pageCount;
  int? total;

  Pagination({this.page, this.pageSize, this.pageCount, this.total});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pageSize = json['pageSize'];
    pageCount = json['pageCount'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pageSize'] = this.pageSize;
    data['pageCount'] = this.pageCount;
    data['total'] = this.total;
    return data;
  }
}

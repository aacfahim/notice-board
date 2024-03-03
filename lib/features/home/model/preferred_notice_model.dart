class PreferredNoticeModel {
  int? id;
  String? title;
  int? categoryId;
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
  Null? noticeFileId;
  String? lastResponseTime;

  PreferredNoticeModel(
      {this.id,
      this.title,
      this.categoryId,
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
      this.noticeFileId,
      this.lastResponseTime});

  PreferredNoticeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    categoryId = json['categoryId'];
    publicationDate = json['publicationDate'];
    dateInNotice = json['dateInNotice'];
    nuNoticePdfLink = json['nuNoticePdfLink'];
    nuNoticeId = json['nuNoticeId'];
    pedTitle = json['pedTitle'];
    pages = json['pages'];
    innerTitle = json['innerTitle'];
    signedByName = json['signedByName'];
    signedByDesignation = json['signedByDesignation'];
    signedByPhone = json['signedByPhone'];
    signedByEmail = json['signedByEmail'];
    signedByName2 = json['signedByName2'];
    signedByDesignation2 = json['signedByDesignation2'];
    signedByPhone2 = json['signedByPhone2'];
    signedByEmail2 = json['signedByEmail2'];
    noticeFileId = json['noticeFileId'];
    lastResponseTime = json['lastResponseTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['categoryId'] = this.categoryId;
    data['publicationDate'] = this.publicationDate;
    data['dateInNotice'] = this.dateInNotice;
    data['nuNoticePdfLink'] = this.nuNoticePdfLink;
    data['nuNoticeId'] = this.nuNoticeId;
    data['pedTitle'] = this.pedTitle;
    data['pages'] = this.pages;
    data['innerTitle'] = this.innerTitle;
    data['signedByName'] = this.signedByName;
    data['signedByDesignation'] = this.signedByDesignation;
    data['signedByPhone'] = this.signedByPhone;
    data['signedByEmail'] = this.signedByEmail;
    data['signedByName2'] = this.signedByName2;
    data['signedByDesignation2'] = this.signedByDesignation2;
    data['signedByPhone2'] = this.signedByPhone2;
    data['signedByEmail2'] = this.signedByEmail2;
    data['noticeFileId'] = this.noticeFileId;
    data['lastResponseTime'] = this.lastResponseTime;
    return data;
  }
}

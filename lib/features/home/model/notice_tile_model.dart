class NoticeTileModel {
  List<NoticeTileDataModel>? data;
  Meta? meta;

  NoticeTileModel({this.data, this.meta});

  NoticeTileModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <NoticeTileDataModel>[];
      json['data'].forEach((v) {
        data!.add(new NoticeTileDataModel.fromJson(v));
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

class NoticeTileDataModel {
  int? id;
  Attributes? attributes;

  NoticeTileDataModel({this.id, this.attributes});

  NoticeTileDataModel.fromJson(Map<String, dynamic> json) {
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
  String? tag;
  String? date;
  bool? isFavourite;
  int? detailsId;
  String? createdAt;
  String? updatedAt;
  String? publishedAt;
  String? locale;

  Attributes(
      {this.title,
      this.tag,
      this.date,
      this.isFavourite,
      this.detailsId,
      this.createdAt,
      this.updatedAt,
      this.publishedAt,
      this.locale});

  Attributes.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    tag = json['tag'];
    date = json['date'];
    isFavourite = json['isFavourite'];
    detailsId = json['details_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    publishedAt = json['publishedAt'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['tag'] = this.tag;
    data['date'] = this.date;
    data['isFavourite'] = this.isFavourite;
    data['details_id'] = this.detailsId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['publishedAt'] = this.publishedAt;
    data['locale'] = this.locale;
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

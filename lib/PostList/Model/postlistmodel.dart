class PostList {
  bool? status;
  List<Data>? data;
  int? currentPage;
  int? pageSize;
  int? totalItems;
  int? totalPages;
  int? nextPage;
  int? previousPage;
  bool? hasMore;

  PostList(
      {this.status,
      this.data,
      this.currentPage,
      this.pageSize,
      this.totalItems,
      this.totalPages,
      this.nextPage,
      this.previousPage,
      this.hasMore});

  PostList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    currentPage = json['currentPage'];
    pageSize = json['pageSize'];
    totalItems = json['totalItems'];
    totalPages = json['totalPages'];
    nextPage = json['nextPage'];
    previousPage = json['previousPage'];
    hasMore = json['hasMore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['currentPage'] = this.currentPage;
    data['pageSize'] = this.pageSize;
    data['totalItems'] = this.totalItems;
    data['totalPages'] = this.totalPages;
    data['nextPage'] = this.nextPage;
    data['previousPage'] = this.previousPage;
    data['hasMore'] = this.hasMore;
    return data;
  }
}

class Data {
  int? id;
  String? title;
  String? body;
  String? image;

  Data({this.id, this.title, this.body, this.image});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['image'] = this.image;
    return data;
  }
}

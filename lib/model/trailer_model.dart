class TrailerModel {
  int id;
  List<ResultsTr> results;

  TrailerModel({this.id, this.results});

  TrailerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['results'] != null) {
      results = new List<ResultsTr>();
      json['results'].forEach((v) {
        results.add(new ResultsTr.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.results != null) {
      data['results'] = this.results.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultsTr {
  String id;
  String key;
  String name;

  ResultsTr(
      {this.id,
      this.key,
      this.name,});

  ResultsTr.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    key = json['key'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['key'] = this.key;
    data['name'] = this.name;
    return data;
  }
}
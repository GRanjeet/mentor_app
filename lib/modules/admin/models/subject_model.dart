class SubjectModel {
  String? year;
  String? sem;
  String? name;
  String? code;

  SubjectModel({
    this.year,
    this.sem,
    this.name,
    this.code,
  });

  SubjectModel.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    sem = json['sem'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    data['sem'] = this.sem;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }
}

class SubjectModel {
  String? code;
  String? year;
  String? name;
  String? sem;

  SubjectModel({
    this.code,
    this.year,
    this.name,
    this.sem,
  });

  SubjectModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    year = json['year'];
    name = json['name'];
    sem = json['sem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['year'] = this.year;
    data['name'] = this.name;
    data['sem'] = this.sem;
    return data;
  }
}

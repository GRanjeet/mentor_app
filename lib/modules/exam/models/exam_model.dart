class ExamModel {
  String? total;
  String? code;
  String? scored;
  String? subName;
  String? examName;
  String? remark;
  bool? isPassed;

  ExamModel({
    this.total,
    this.code,
    this.scored,
    this.subName,
    this.examName,
    this.remark,
    this.isPassed,
  });

  ExamModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    code = json['code'];
    scored = json['scored'];
    subName = json['subName'];
    examName = json['examName'];
    remark = json['remark'];
    isPassed = json['isPassed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['code'] = this.code;
    data['scored'] = this.scored;
    data['subName'] = this.subName;
    data['examName'] = this.examName;
    data['remark'] = this.remark;
    data['isPassed'] = this.isPassed;
    return data;
  }
}

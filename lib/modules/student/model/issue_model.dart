import 'package:mentor_app/modules/admin/models/subject_model.dart';

class IssueModel {
  String? msg;
  String? issueType;
  String? createdAt;
  bool? forAdvisor;
  String? id;
  String? title;
  SubjectModel? subject;

  IssueModel({
    this.msg,
    this.issueType,
    this.createdAt,
    this.forAdvisor,
    this.id,
    this.title,
    this.subject,
  });

  IssueModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    issueType = json['issueType'];
    createdAt = json['createdAt'];
    forAdvisor = json['forAdvisor'];
    id = json['id'];
    title = json['title'];
    subject = json['subject'] != null ? new SubjectModel.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg'] = this.msg;
    data['issueType'] = this.issueType;
    data['createdAt'] = this.createdAt;
    data['forAdvisor'] = this.forAdvisor;
    data['id'] = this.id;
    data['title'] = this.title;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    return data;
  }
}

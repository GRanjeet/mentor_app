import '../../student/model/issue_model.dart';

class NotificationModel {
  String? studentId;
  bool? hasRead;
  IssueModel? issue;

  NotificationModel({this.studentId, this.hasRead, this.issue});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    studentId = json['studentId'];
    hasRead = json['hasRead'];
    issue = json['issue'] != null ? new IssueModel.fromJson(json['issue']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['studentId'] = this.studentId;
    data['hasRead'] = this.hasRead;
    if (this.issue != null) {
      data['issue'] = this.issue!.toJson();
    }
    return data;
  }
}

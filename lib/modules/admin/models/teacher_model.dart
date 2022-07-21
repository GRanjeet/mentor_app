import 'subject_model.dart';

class TeacherModel {
  bool? isAdvisor;
  String? phone;
  SubjectModel? subject;
  String? fullName;
  String? id;
  String? email;

  TeacherModel({
    this.isAdvisor,
    this.phone,
    this.subject,
    this.fullName,
    this.id,
    this.email,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    isAdvisor = json['isAdvisor'];
    phone = json['phone'];
    subject = json['subject'] != null ? new SubjectModel.fromJson(json['subject']) : null;
    fullName = json['fullName'];
    id = json['id'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isAdvisor'] = this.isAdvisor;
    data['phone'] = this.phone;
    if (this.subject != null) {
      data['subject'] = this.subject!.toJson();
    }
    data['fullName'] = this.fullName;
    data['id'] = this.id;
    data['email'] = this.email;
    return data;
  }
}

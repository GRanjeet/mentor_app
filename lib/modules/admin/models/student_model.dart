import 'package:mentor_app/modules/exam/models/exam_model.dart';

import 'subject_model.dart';

class StudentModel {
  String? address;
  String? phone;
  String? year;
  List<String>? subjectsIds;
  String? fullName;
  String? id;
  List<Attendence>? attendence;
  String? email;
  List<ExamModel>? exams;

  StudentModel({
    this.address,
    this.phone,
    this.subjectsIds,
    this.fullName,
    this.id,
    this.attendence,
    this.email,
    this.exams,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    this.address = json["address"];
    this.phone = json["phone"];
    this.year = json["year"];
    this.subjectsIds = json["subjectsIds"] == null ? [] : List<String>.from(json["subjectsIds"]);
    this.fullName = json["fullName"];
    this.id = json["id"];
    this.attendence = json["attendence"] == null
        ? []
        : (json["attendence"] as List).map((e) => Attendence.fromJson(e)).toList();
    this.email = json["email"];
    this.exams = json["exams"] == null
        ? []
        : (json["exams"] as List).map((e) => ExamModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["address"] = this.address;
    data["phone"] = this.phone;
    data["year"] = this.year;
    if (this.subjectsIds != null) data["subjectsIds"] = this.subjectsIds;
    data["fullName"] = this.fullName;
    data["id"] = this.id;
    if (this.attendence != null)
      data["attendence"] = this.attendence!.map((e) => e.toJson()).toList();
    data["email"] = this.email;
    return data;
  }
}

class Attendence {
  String? date;
  SubjectModel? subject;
  bool? isPresent;
  String? startTime;
  String? endTime;
  String? classType;

  Attendence({
    this.date,
    this.subject,
    this.isPresent,
    this.startTime,
    this.endTime,
    this.classType,
  });

  Attendence.fromJson(Map<String, dynamic> json) {
    this.date = json["date"];
    this.subject = json["subject"] == null ? null : SubjectModel.fromJson(json["subject"]);
    this.isPresent = json["isPresent"];
    this.startTime = json["startTime"];
    this.endTime = json["endTime"];
    this.classType = json["classType"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["date"] = this.date;
    data["subject"] = this.subject!.toJson();
    data["isPresent"] = this.isPresent;
    data["startTime"] = this.startTime;
    data["endTime"] = this.endTime;
    data["classType"] = this.classType;
    return data;
  }
}

class StudentModel {
  List<Exams>? exams;
  String? address;
  String? teacherId;
  String? teacherName;
  String? phone;
  String? year;
  List<Subjects>? subjects;
  String? fullName;
  String? id;
  String? email;
  List<Attendance>? attendance;

  StudentModel({
    this.exams,
    this.address,
    this.teacherId,
    this.teacherName,
    this.phone,
    this.year,
    this.subjects,
    this.fullName,
    this.id,
    this.email,
    this.attendance,
  });

  StudentModel.fromJson(Map<String, dynamic> json) {
    if (json['exams'] != null) {
      exams = <Exams>[];
      json['exams'].forEach((v) {
        exams!.add(new Exams.fromJson(v));
      });
    }
    address = json['address'];
    teacherId = json['teacherId'];
    teacherName = json['teacherName'];
    phone = json['phone'];
    year = json['year'];
    if (json['subjects'] != null) {
      subjects = <Subjects>[];
      json['subjects'].forEach((v) {
        subjects!.add(new Subjects.fromJson(v));
      });
    }
    fullName = json['fullName'];
    id = json['id'];
    email = json['email'];
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(new Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.exams != null) {
      data['exams'] = this.exams!.map((v) => v.toJson()).toList();
    }
    data['address'] = this.address;
    data['teacherId'] = this.teacherId;
    data['teacherName'] = this.teacherName;
    data['phone'] = this.phone;
    data['year'] = this.year;
    if (this.subjects != null) {
      data['subjects'] = this.subjects!.map((v) => v.toJson()).toList();
    }
    data['fullName'] = this.fullName;
    data['id'] = this.id;
    data['email'] = this.email;
    if (this.attendance != null) {
      data['attendance'] = this.attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Exams {
  String? feedback;
  String? examName;
  String? totalMarks;
  String? subjectCode;
  String? scoredMarks;

  Exams({
    this.feedback,
    this.examName,
    this.totalMarks,
    this.subjectCode,
    this.scoredMarks,
  });

  Exams.fromJson(Map<String, dynamic> json) {
    feedback = json['feedback'];
    examName = json['examName'];
    totalMarks = json['totalMarks'];
    subjectCode = json['subjectCode'];
    scoredMarks = json['scoredMarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['feedback'] = this.feedback;
    data['examName'] = this.examName;
    data['totalMarks'] = this.totalMarks;
    data['subjectCode'] = this.subjectCode;
    data['scoredMarks'] = this.scoredMarks;
    return data;
  }
}

class Subjects {
  String? year;
  List<Sem>? sem;

  Subjects({
    this.year,
    this.sem,
  });

  Subjects.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    if (json['sem'] != null) {
      sem = <Sem>[];
      json['sem'].forEach((v) {
        sem!.add(new Sem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['year'] = this.year;
    if (this.sem != null) {
      data['sem'] = this.sem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Sem {
  List<SubList>? subList;
  String? name;

  Sem({
    this.subList,
    this.name,
  });

  Sem.fromJson(Map<String, dynamic> json) {
    if (json['subList'] != null) {
      subList = <SubList>[];
      json['subList'].forEach((v) {
        subList!.add(new SubList.fromJson(v));
      });
    }
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.subList != null) {
      data['subList'] = this.subList!.map((v) => v.toJson()).toList();
    }
    data['name'] = this.name;
    return data;
  }
}

class SubList {
  String? subCode;
  String? subName;

  SubList({
    this.subCode,
    this.subName,
  });

  SubList.fromJson(Map<String, dynamic> json) {
    subCode = json['subCode'];
    subName = json['subName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subCode'] = this.subCode;
    data['subName'] = this.subName;
    return data;
  }
}

class Attendance {
  String? date;
  String? isPresent;

  Attendance({
    this.date,
    this.isPresent,
  });

  Attendance.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    isPresent = json['isPresent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['isPresent'] = this.isPresent;
    return data;
  }
}

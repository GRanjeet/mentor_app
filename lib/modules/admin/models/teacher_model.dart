class TeacherModel {
  String? phone;
  String? fullName;
  String? email;

  TeacherModel({
    this.phone,
    this.fullName,
    this.email,
  });

  TeacherModel.fromJson(Map<String, dynamic> json) {
    phone = json['phone'];
    fullName = json['fullName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phone'] = this.phone;
    data['fullName'] = this.fullName;
    data['email'] = this.email;
    return data;
  }

  TeacherModel copyWith({
    String? phone,
    String? fullName,
    String? email,
  }) {
    return TeacherModel(
      phone: phone ?? this.phone,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
    );
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/student_model.dart';
import '../models/teacher_model.dart';

class ViewUsersController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('students');

  final isLoading = false.obs;
  final isTeacher = false.obs;
  final showStudents = false.obs;
  final teacherData = TeacherModel().obs;
  var teachersList = <TeacherModel>[].obs;
  var studentsList = <StudentModel>[].obs;

  @override
  void onInit() {
    teachersList.value = [];
    studentsList.value = [];
    var data = Get.arguments;
    log(data.toString());
    isTeacher.value = data['isTeacher'];
    showStudents.value = data['showStudents'];

    if (showStudents.value) {
      teacherData.value = data['teacher'];
      getTeacherStudentsData(teacherData.value.id!);
    } else {
      getUsersData();
    }
    super.onInit();
  }

  void getUsersData() async {
    isLoading.value = true;
    teachersList.value = [];
    studentsList.value = [];
    await FirebaseFirestore.instance
        .collection(isTeacher.value ? 'teachers' : 'students')
        .get()
        .then(
      (value) {
        value.docs.forEach(
          (doc) {
            var data = doc.data();
            log(jsonEncode(data));
            if (isTeacher.value) {
              teachersList.add(TeacherModel.fromJson(data));
            } else {
              studentsList.add(StudentModel.fromJson(data));
            }
          },
        );
      },
    );
    isLoading.value = false;
  }

  void getTeacherStudentsData(String teacherId) async {
    isLoading.value = true;
    teachersList.value = [];
    studentsList.value = [];
    await _db.where('teacherId', isEqualTo: teacherId).get().then((value) {
      value.docs.forEach((doc) {
        var data = doc.data();
        studentsList.add(StudentModel.fromJson(data));
      });
    });
    isLoading.value = false;
  }
}

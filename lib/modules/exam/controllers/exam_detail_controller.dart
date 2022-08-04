import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/student/controllers/student_detail_controller.dart';
import 'package:mentor_app/modules/admin/models/student_model.dart';
import 'package:mentor_app/modules/exam/models/exam_model.dart';

class ExamDetailController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('students');

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final studentId = ''.obs;
  final subjectCode = ''.obs;
  final subjectName = ''.obs;
  final isPassed = false.obs;
  final examList = <ExamModel>[].obs;
  final studentData = StudentModel().obs;

  final passed = ''.obs;
  final passedList = <String>['Yes', 'No'];

  final formkey = GlobalKey<FormState>();
  final examNameTextController = TextEditingController();
  final scoredTextController = TextEditingController();
  final totalTextController = TextEditingController();
  final feedbackController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    final studentController = Get.find<StudentDetailController>();
    var args = Get.arguments as Map<String, dynamic>;
    log(args.toString());
    studentData.value = studentController.studentData.value;
    studentId.value = args['studentId'];
    subjectCode.value = args['subjectCode'];
    subjectName.value = args['subjectName'];
    getExamList();
  }

  void getExamList() async {
    _isLoading.value = true;
    examList.value = [];

    await _db.doc(studentId.value).get().then(
      (value) {
        studentData.value = StudentModel.fromJson(value.data() as Map<String, dynamic>);
      },
    );

    if (studentData.value.exams != null) {
      studentData.value.exams!.forEach((element) {
        if (subjectCode.value == element.code) {
          examList.add(element);
        }
      });
    }
    _isLoading.value = false;
  }

  void addExamDetail() async {
    if (formkey.currentState!.validate()) {
      _isLoading.value = true;
      var data = {
        "code": subjectCode.value,
        "subName": subjectName.value,
        "examName": examNameTextController.text.trim(),
        "scored": scoredTextController.text.trim(),
        "total": totalTextController.text.trim(),
        "remark": feedbackController.text.trim(),
        "isPassed": passed.value == 'Yes' ? true : false,
      };

      // await _db.doc(studentId.value).collection("exams").add(data).then(
      //       (value) => {
      //         log('Exam Added'),
      //         Get.back(),
      //       },
      //     );

      try {
        await _db.doc(studentId.value).update({
          'exams': FieldValue.arrayUnion([data])
        }).then((value) {
          Get.back();
          Get.rawSnackbar(
            title: 'Success',
            message: "Attendence added successfully",
            backgroundColor: Colors.green,
          );
        });
      } catch (e) {
        log(e.toString());
      }
      _isLoading.value = false;
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/exam/models/exam_model.dart';

class ExamDetailController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('students');

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;

  final studentId = ''.obs;
  final subjectCode = ''.obs;
  final subjectName = ''.obs;
  final examList = <ExamModel>[].obs;

  final formkey = GlobalKey<FormState>();
  final examNameTextController = TextEditingController();
  final scoredTextController = TextEditingController();
  final totalTextController = TextEditingController();
  final feedbackController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    var args = Get.arguments as Map<String, dynamic>;
    log(args.toString());
    studentId.value = args['studentId'];
    subjectCode.value = args['subjectCode'];
    subjectName.value = args['subjectName'];
    getExamList();
  }

  void getExamList() async {
    _isLoading.value = true;
    examList.value = [];
    await _db
        .doc(studentId.value)
        .collection("exams")
        .where('code', isEqualTo: subjectCode.value)
        .get()
        .then(
      (value) {
        value.docs.forEach((doc) {
          log(jsonEncode(doc.data()).toString());
          examList.add(ExamModel.fromJson(doc.data()));
        });
      },
    );
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
      };

      await _db.doc(studentId.value).collection("exams").add(data).then(
            (value) => {
              log('Exam Added'),
              Get.back(),
            },
          );
      _isLoading.value = false;
    }
  }
}

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/student_model.dart';
import '../models/subject_model.dart';

class StudentDetailController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('students');

  final isLoading = false.obs;
  final studentData = StudentModel().obs;
  final subjectsList = <Subjects>[].obs;
  final fySubjectDataList = <SubjectModel>[].obs;
  final sySubjectDataList = <SubjectModel>[].obs;
  final tySubjectDataList = <SubjectModel>[].obs;

  final isFyExpanded = false.obs;
  final isSyExpanded = false.obs;
  final isTyExpanded = false.obs;

  @override
  void onInit() {
    studentData.value = Get.arguments;
    subjectsList.value = studentData.value.subjects!;
    print(jsonEncode(studentData.toJson().toString()));
    super.onInit();
  }

  void getSubjectList() async {
    isLoading.value = true;
    fySubjectDataList.value = [];
    sySubjectDataList.value = [];
    tySubjectDataList.value = [];

    log(studentData.value.id.toString());
    await _db
        .doc(studentData.value.id)
        .collection("subjects")
        .orderBy('sem', descending: false)
        .get()
        .then((value) {
      value.docs.forEach((doc) {
        if (doc['year'] == 'FY') {
          fySubjectDataList.add(SubjectModel.fromJson(doc.data()));
        } else if (doc['year'] == 'SY') {
          sySubjectDataList.add(SubjectModel.fromJson(doc.data()));
        } else if (doc['year'] == 'TY') {
          tySubjectDataList.add(SubjectModel.fromJson(doc.data()));
        }
      });
    });
    isLoading.value = false;
  }
}

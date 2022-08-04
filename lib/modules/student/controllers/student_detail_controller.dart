import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/modules/admin/models/teacher_model.dart';
import 'package:mentor_app/modules/student/model/issue_model.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/notification_service.dart';
import '../../admin/models/student_model.dart';
import '../../admin/models/subject_model.dart';

class StudentDetailController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('students');
  final _teachersDB = FirebaseFirestore.instance.collection('teachers');

  final isLoading = false.obs;
  final isStudent = false.obs;

  final selectedType = ''.obs;
  final selectedIssueType = ''.obs;

  final studentData = StudentModel().obs;
  final allSubjectDataList = <SubjectModel>[].obs;
  final fySubjectDataList = <SubjectModel>[].obs;
  final sySubjectDataList = <SubjectModel>[].obs;
  final tySubjectDataList = <SubjectModel>[].obs;
  final issueList = <IssueModel>[].obs;
  final selectedSubject = SubjectModel().obs;

  final issueFormKey = GlobalKey<FormState>();
  final titleTextController = TextEditingController();
  final msgTextController = TextEditingController();

  final isFyExpanded = false.obs;
  final isSyExpanded = false.obs;
  final isTyExpanded = false.obs;

  final attPercentage = 0.0.obs;
  final examPercentage = 0.0.obs;
  final overPercentage = 0.0.obs;

  final typeList = ['Teacher', 'Advisor'];

  final issueTypeList = [
    'Stress',
    'Medical',
    'Lack of Confidence',
  ];

  final yearList = [
    'First Year',
    'Second Year',
    'Third Year',
  ];
  late final LocalNotificationService service;
  @override
  void onInit() {
    studentData.value = Get.arguments['studentData'];
    isStudent.value = Get.arguments['isStudent'];
    log(jsonEncode(studentData.toJson().toString()));
    log(isStudent.value.toString());
    getStudentData();
    getIssuesList();
    getSubjectList();
    calculatedPerformance();
    service = LocalNotificationService();
    service.intialize();
    loadData();
    super.onInit();
  }

  void loadData() async {
    await service.showNotification(
      id: 0,
      title: 'Notification Title',
      body: 'Some body',
    );
  }

  void getStudentData() async {
    isLoading.value = true;
    final _db = FirebaseFirestore.instance.collection('students');
    try {
      await _db.doc(studentData.value.id).get().then((value) {
        var data = value.data() as Map<String, dynamic>;
        log(data.toString());
        studentData.value = StudentModel.fromJson(data);
      });
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }

  void getSubjectList() async {
    isLoading.value = true;
    allSubjectDataList.value = [];
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
        allSubjectDataList.add(SubjectModel.fromJson(doc.data()));
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

  void calculatedPerformance() {
    var attendenceList = studentData.value.attendence ?? [];
    var examsList = studentData.value.exams ?? [];
    var attLength = studentData.value.attendence!.length;
    var examLength = studentData.value.exams!.length;

    var attCount = 0;
    var examCount = 0;
    if (attendenceList.isNotEmpty) {
      attendenceList.forEach((att) {
        if (att.isPresent!) attCount += 1;
        log(attCount.toString());
      });
      attPercentage.value = (attCount / attLength).toPrecision(2);
    }

    if (examsList.isNotEmpty) {
      examsList.forEach((exam) {
        if (exam.isPassed!) examCount += 1;
        log(examCount.toString());
      });
      examPercentage.value = (examCount / examLength).toPrecision(2);
    }

    overPercentage.value = ((attPercentage.value + examPercentage.value) / 2).toPrecision(2);

    log('attPercentage : ${attPercentage.value.toString()}');
    log('examPercentage : ${examPercentage.value.toString()}');
    log('overPercentage : ${overPercentage.value.toString()}');
  }

  void getIssuesList() async {
    isLoading.value = true;
    issueList.value = [];
    await _db.doc(studentData.value.id).collection("issues").get().then(
      (value) {
        value.docs.forEach((doc) {
          log(jsonEncode(doc.data()));
          issueList.add(IssueModel.fromJson(doc.data()));
        });
      },
    );
    isLoading.value = false;
  }

  void addIssue() async {
    if (issueFormKey.currentState!.validate()) {
      isLoading.value = true;
      var id = Uuid().v1();
      var dateTime = DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now());

      var issue = IssueModel(
        id: id,
        title: titleTextController.text,
        msg: msgTextController.text,
        issueType: selectedIssueType.value,
        createdAt: dateTime,
        forAdvisor: selectedType.value == typeList[0] ? false : true,
        subject: selectedType.value == typeList[0] ? selectedSubject.value : null,
      );
      Map<String, dynamic> data = issue.toJson();
      log(data.toString());

      await _db.doc(studentData.value.id).collection("issues").doc(id).set(data).then(
        (value) {
          Get.rawSnackbar(
            message: 'Issue added sucessfuly',
            backgroundColor: Colors.green,
          );
        },
      );

      if (selectedType.value == typeList[0]) {
        await _teachersDB
            .where('subject.code', isEqualTo: selectedSubject.value.code)
            .get()
            .then((value) {
          value.docs.forEach((doc) async {
            log(jsonEncode(doc.data()));
            var teacher = TeacherModel.fromJson(doc.data());
            sendToTeacher(teacher.id!, data, id);
          });
        });
      } else if (selectedType.value == typeList[1]) {
        await _teachersDB.where('isAdvisor', isEqualTo: true).get().then((value) {
          value.docs.forEach((doc) async {
            log(jsonEncode(doc.data()));
            var teacher = TeacherModel.fromJson(doc.data());
            sendToTeacher(teacher.id!, data, id);
            await service.showNotification(
              id: 0,
              title: issue.title!,
              body: issue.msg!,
            );
          });
        });
      }
      selectedType.value = '';
      selectedIssueType.value = '';
      selectedSubject.value = SubjectModel();
      titleTextController.clear();
      msgTextController.clear();
      isLoading.value = false;
    }
  }

  void sendToTeacher(String id, Map<String, dynamic> issue, String issueId) async {
    Map<String, dynamic> data = {
      'studentId': studentData.value.id,
      'issue': issue,
      'hasRead': false,
    };
    await _teachersDB.doc(id).collection('notifications').doc(issueId).set(data).then((value) {
      log('Notification sended.....');
    });
  }

  Color currentProgressColor(double progress) {
    if (progress >= 0.75) {
      return Colors.blue;
    } else if (progress >= 0.5) {
      return Colors.green;
    } else if (progress >= 0.35) {
      return Colors.orange;
    } else if (progress >= 0.25) {
      return Colors.red;
    } else {
      return Colors.black;
    }
  }
}

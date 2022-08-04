import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/modules/student/controllers/student_detail_controller.dart';
import 'package:mentor_app/modules/admin/models/student_model.dart';

import '../../admin/models/subject_model.dart';

class AttendenceController extends GetxController {
  final studentController = Get.find<StudentDetailController>();
  final _isLoading = false.obs;
  get isLoading => this._isLoading.value;

  final selectedSubject = SubjectModel().obs;
  final subjectsList = <SubjectModel>[].obs;
  final selectedtDate = ''.obs;
  final selectedtStartTime = ''.obs;
  final selectedtEndTime = ''.obs;

  final calSelectedDate = DateTime.now().obs;

  final dateTextController = TextEditingController();
  final startTimeTextController = TextEditingController();
  final endTimeTextController = TextEditingController();

  final present = ''.obs;
  final presentList = <String>['Yes', 'No'];

  final selectedClassType = ''.obs;
  final classTypeList = <String>[
    'Tutorials',
    'Lectures',
    'Laboratory',
    'Seminars',
    'Exam',
  ];

  final studentData = StudentModel().obs;
  final selectedDateAttendenceList = <Attendence>[].obs;

  @override
  void onInit() {
    studentData.value = Get.find<StudentDetailController>().studentData.value;
    log(studentData.value.toJson().toString());
    getSubjectsList();
    super.onInit();
  }

  void getStudentData() async {
    _isLoading.value = true;
    final _db = FirebaseFirestore.instance.collection('students');
    try {
      await _db.doc(studentData.value.id).get().then((value) {
        var data = value.data() as Map<String, dynamic>;
        studentData.value = StudentModel.fromJson(data);
      });
      loadSelectedDateList(calSelectedDate.value);
    } catch (e) {
      log(e.toString());
    }
    _isLoading.value = false;
  }

  void getSubjectsList() async {
    _isLoading.value = true;
    log('Getting subjects list...');
    final _db = FirebaseFirestore.instance.collection('subjects');
    try {
      await _db.get().then((value) {
        value.docs.forEach((doc) {
          var data = doc.data();
          log(jsonEncode(data).toString());
          subjectsList.add(SubjectModel.fromJson(data));
        });
      });
    } catch (e) {
      log(e.toString());
    }
    _isLoading.value = false;
  }

  void loadSelectedDateList(DateTime date) {
    selectedDateAttendenceList.value = [];
    calSelectedDate.value = date;
    var tempDate = DateFormat('dd-MM-yyyy').format(date);
    studentData.value.attendence!.forEach((element) {
      if (element.date == tempDate) {
        selectedDateAttendenceList.add(element);
      }
      log(selectedDateAttendenceList.length.toString());
    });
    log(date.toIso8601String());
  }

  void addAttendence() async {
    _isLoading.value = true;
    final _db = FirebaseFirestore.instance.collection('students');
    var id = studentController.studentData.value.id;
    Map<String, dynamic> data = {
      "classType": selectedClassType.value,
      "isPresent": present.value == 'Yes' ? true : false,
      "date": selectedtDate.value,
      "startTime": selectedtStartTime.value,
      "endTime": selectedtEndTime.value,
      "subject": selectedSubject.toJson(),
    };
    log(data.toString());
    try {
      await _db.doc(id).update({
        'attendence': FieldValue.arrayUnion([data])
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

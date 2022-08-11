import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/modules/admin/models/teacher_model.dart';
import 'package:mentor_app/modules/student/model/issue_model.dart';
import 'package:mentor_app/modules/student/views/weekly_report.dart';
import 'package:uuid/uuid.dart';

import '../../../utils/notification_service.dart';
import '../../admin/models/student_model.dart';
import '../../admin/models/subject_model.dart';
import '../../teacher/model/chat_model.dart';

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
  final reportFormKey = GlobalKey<FormState>();

  final titleTextController = TextEditingController();
  final msgTextController = TextEditingController();
  final chatMsgTextController = TextEditingController();
  final chatList = <ChatModel>[].obs;
  final selectedIssue = IssueModel().obs;

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

  final ratingList = [
    "Excellent",
    "Good",
    "Unsatisfactory",
  ];

  final selectedRating1 = ''.obs;
  final selectedRating2 = ''.obs;
  final selectedRating3 = ''.obs;
  final selectedRating4 = ''.obs;
  final selectedRating5 = ''.obs;
  final selectedRating6 = ''.obs;

  late final LocalNotificationService service;
  @override
  void onInit() {
    service = LocalNotificationService();
    service.intialize();
    studentData.value = Get.arguments['studentData'];
    isStudent.value = Get.arguments['isStudent'];
    log(jsonEncode(studentData.toJson().toString()));
    log(isStudent.value.toString());
    getStudentData();
    getIssuesList();
    getSubjectList();
    calculatedPerformance();
    if (isStudent.value) generateAttendanceNotifications();
    if (isStudent.value) showWeeklyNotification();
    super.onInit();
  }

  void showWeeklyNotification() async {
    var day = DateTime.now().weekday;
    log('Week Day : $day');

    if (day == DateTime.monday) {
      await service.showNotification(
        id: math.Random().nextInt(1000),
        title: 'Weekly Progress',
        body: 'Please provide your last week progress.',
        payload: NotificationKeys.weeklyKey,
      );
    }
  }

  void showWeeklyDialog() {
    Get.dialog(WeeklyDialog());
  }

  void saveWeeklyReportData() async {
    if (reportFormKey.currentState!.validate()) {
      Get.back();
      Get.back();

      final _db = FirebaseFirestore.instance.collection('students');
      var id = Uuid().v1();
      var dateTime = DateFormat('dd-MM-yyyy hh:mm').format(DateTime.now());

      if (selectedRating1.value == ratingList[2] ||
          selectedRating2.value == ratingList[2] ||
          selectedRating6.value == ratingList[2]) {
        await service.showNotification(
          id: math.Random().nextInt(1000),
          title: 'Alert!',
          body: 'Please check the given resources.',
          payload: NotificationKeys.helpKey,
        );
      }

      Map<String, dynamic> data = {
        "id": id,
        "createdAt": dateTime,
        "health": selectedRating1.value,
        "behaviour": selectedRating2.value,
        "reading": selectedRating3.value,
        "writing": selectedRating4.value,
        "workHabit": selectedRating5.value,
        "socialHabit": selectedRating6.value,
      };

      try {
        await _db.doc(studentData.value.id).collection("reports").doc(id).set(data).then(
          (value) {
            Get.rawSnackbar(
              message: 'Report added sucessfuly',
              backgroundColor: Colors.green,
            );
          },
        );
      } catch (e) {
        log(e.toString());
      }
    }
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
              id: math.Random().nextInt(1000),
              title: 'Alert!',
              body: 'Please check the given resources.',
              payload: NotificationKeys.helpKey,
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

  void generateAttendanceNotifications() async {
    int attCount = 0;

    if (studentData.value.attendence!.isNotEmpty) {
      studentData.value.attendence!.sort(((a, b) {
        int aDate = DateFormat("yyyy-MM-dd").parse(a.date ?? '').microsecondsSinceEpoch;
        int bDate = DateFormat("yyyy-MM-dd").parse(b.date ?? '').microsecondsSinceEpoch;
        return aDate.compareTo(bDate);
      }));

      studentData.value.attendence!.forEach((element) async {
        if (!element.isPresent!) {
          attCount = attCount + 1;
          if (attCount == 3) {
            await service.showNotification(
              id: math.Random().nextInt(1000),
              title: 'Attendance Report',
              body:
                  'Hi, you have been absent from last 3 days so, please report to your respective teacher.',
              payload: NotificationKeys.attendenceKey,
            );
          }
        } else {
          attCount = 0;
        }
        log('Attendance : ${attCount.toString()}');
      });
    }
  }

  Stream<List<ChatModel>> chatsStream() {
    final _studentsDB = FirebaseFirestore.instance.collection('students');
    return _studentsDB
        .doc(studentData.value.id)
        .collection('issues')
        .doc(selectedIssue.value.id)
        .collection('chats')
        .snapshots()
        .map((value) {
      List<ChatModel> list = [];
      value.docs.forEach((hint) {
        var data = hint.data();
        log(jsonEncode(data));
        list.add(ChatModel.fromJson(data));
      });
      chatList.value = list;
      chatList.sort(((a, b) {
        int aDate =
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(a.timeStamp ?? '').microsecondsSinceEpoch;
        int bDate =
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(b.timeStamp ?? '').microsecondsSinceEpoch;
        return aDate.compareTo(bDate);
      }));
      return list;
    });
  }

  void sendChat() async {
    if (chatMsgTextController.text.isNotEmpty) {
      final _studentsDB = FirebaseFirestore.instance.collection('students');
      var chat = ChatModel(
        timeStamp: DateTime.now().toString(),
        isMe: true,
        msg: chatMsgTextController.text.trim(),
      );
      Map<String, dynamic> data = chat.toJson();
      chatMsgTextController.clear();
      await _studentsDB
          .doc(studentData.value.id)
          .collection('issues')
          .doc(selectedIssue.value.id)
          .collection('chats')
          .add(data);
    }
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

import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mentor_app/modules/admin/models/student_model.dart';
import 'package:mentor_app/modules/admin/models/teacher_model.dart';
import 'package:mentor_app/modules/teacher/model/chat_model.dart';
import 'package:mentor_app/modules/teacher/model/notification_model.dart';
import 'package:mentor_app/utils/notification_service.dart';

class TeacherDetailController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('teachers');

  final isLoading = false.obs;
  final isTeacher = false.obs;
  final isAdvisor = false.obs;
  final issueList = <NotificationModel>[].obs;
  final teacherData = TeacherModel().obs;
  final selectedIssue = NotificationModel().obs;
  final studentData = StudentModel().obs;
  final chatList = <ChatModel>[].obs;

  final msgTextController = TextEditingController();
  late final LocalNotificationService service;

  @override
  void onInit() {
    isTeacher.value = Get.arguments['isTeacher'];
    teacherData.value = Get.arguments['teacherData'];
    isAdvisor.value = teacherData.value.isAdvisor!;
    log(jsonEncode(teacherData.toJson().toString()));
    service = LocalNotificationService();
    service.intialize();
    if (isTeacher.value) getIssuesList();
    super.onInit();
  }

  void showNotifications() async {
    for (var i = 0; i < issueList.length; i++) {
      if (!issueList[i].hasRead!) {
        await service.showNotification(
          id: i,
          title: issueList[i].issue!.title!,
          body: issueList[i].issue!.msg!,
          payload: NotificationKeys.issueKey,
        );
      }
    }
  }

  void getIssuesList() async {
    isLoading.value = true;
    issueList.value = [];
    await _db.doc(teacherData.value.id).collection("notifications").get().then(
      (value) {
        value.docs.forEach((doc) {
          log(jsonEncode(doc.data()));
          issueList.add(NotificationModel.fromJson(doc.data()));
        });
        showNotifications();
      },
    );
    isLoading.value = false;
  }

  Stream<List<ChatModel>> chatsStream() {
    final _studentsDB = FirebaseFirestore.instance.collection('students');
    return _studentsDB
        .doc(selectedIssue.value.studentId)
        .collection('issues')
        .doc(selectedIssue.value.issue!.id)
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

  void getStudentDetails() async {
    isLoading.value = true;
    final _studentsDB = FirebaseFirestore.instance.collection('students');
    await _studentsDB.doc(selectedIssue.value.studentId).get().then((value) {
      var data = value.data() as Map<String, dynamic>;
      studentData.value = StudentModel.fromJson(data);
    });
    isLoading.value = false;
  }

  void updateIssueStatus() async {
    await _db
        .doc(teacherData.value.id)
        .collection('notifications')
        .doc(selectedIssue.value.issue!.id)
        .update({'hasRead': true}).then((value) {
      log('Notification Status updated...');
    });
  }

  void sendChat() async {
    if (msgTextController.text.isNotEmpty) {
      final _studentsDB = FirebaseFirestore.instance.collection('students');
      var chat = ChatModel(
        timeStamp: DateTime.now().toString(),
        isMe: false,
        msg: msgTextController.text.trim(),
      );
      Map<String, dynamic> data = chat.toJson();
      msgTextController.clear();
      await _studentsDB
          .doc(selectedIssue.value.studentId)
          .collection('issues')
          .doc(selectedIssue.value.issue!.id)
          .collection('chats')
          .add(data);
    }
  }
}

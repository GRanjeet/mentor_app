import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:mentor_app/modules/admin/models/teacher_model.dart';
import 'package:mentor_app/utils/notification_service.dart';

class TeacherDetailController extends GetxController {
  final isLoading = false.obs;
  final isTeacher = false.obs;
  final isAdvisor = false.obs;
  final teacherData = TeacherModel().obs;

  late final LocalNotificationService service;

  @override
  void onInit() {
    teacherData.value = Get.arguments['teacherData'];
    isTeacher.value = Get.arguments['isTeacher'];
    isAdvisor.value = teacherData.value.isAdvisor!;
    log(jsonEncode(teacherData.toJson().toString()));
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
}

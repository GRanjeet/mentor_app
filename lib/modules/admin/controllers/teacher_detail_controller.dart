import 'dart:convert';

import 'package:get/get.dart';
import 'package:mentor_app/modules/admin/models/teacher_model.dart';

class TeacherDetailController extends GetxController {
  final isLoading = false.obs;
  final teacherData = TeacherModel().obs;

  @override
  void onInit() {
    teacherData.value = Get.arguments;
    print(jsonEncode(teacherData.toJson().toString()));
    super.onInit();
  }
}

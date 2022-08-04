import 'package:get/get.dart';
import 'package:mentor_app/modules/teacher/controllers/teacher_detail_controller.dart';

class TeacherDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TeacherDetailController());
  }
}

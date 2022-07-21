import 'package:get/get.dart';
import 'package:mentor_app/modules/admin/controllers/subject_controller.dart';

class SubjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SubjectController());
  }
}

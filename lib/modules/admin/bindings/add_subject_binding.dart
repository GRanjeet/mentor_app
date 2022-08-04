import 'package:get/get.dart';

import '../controllers/add_subject_controller.dart';

class AddSubjectBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddSubjectController());
  }
}

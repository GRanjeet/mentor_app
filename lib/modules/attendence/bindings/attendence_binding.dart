import 'package:get/get.dart';

import '../controllers/attendence_controller.dart';

class AttendenceBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AttendenceController());
  }
}

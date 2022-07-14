import 'package:get/get.dart';

import '../controllers/view_users.controller.dart';

class ViewUsersBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ViewUsersController());
  }
}

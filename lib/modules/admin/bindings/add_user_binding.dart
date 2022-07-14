import 'package:get/get.dart';
import '../controllers/add_user_controller.dart';

class AdduserBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddUserController());
  }
}

import 'package:get/route_manager.dart';

import '../modules/admin/views/add_student_view.dart';
import '../modules/admin/views/add_teacher_view.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/login/login_view.dart';
import '../modules/student/student_view.dart';
import '../modules/teacher/teacher_view.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.loginRoute,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.adminRoute,
      page: () => AdminView(),
    ),
    GetPage(
      name: AppRoutes.teacherRoute,
      page: () => TeacherView(),
    ),
    GetPage(
      name: AppRoutes.studentRoute,
      page: () => StudentView(),
    ),
    GetPage(
      name: AppRoutes.addTeacherRoute,
      page: () => AddTeacherView(),
    ),
    GetPage(
      name: AppRoutes.addStudentRoute,
      page: () => AddStudentView(),
    ),
  ];
}

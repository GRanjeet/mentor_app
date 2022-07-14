import 'package:get/route_manager.dart';

import '../modules/admin/bindings/add_user_binding.dart';
import '../modules/admin/bindings/student_detail_binding.dart';
import '../modules/admin/bindings/view_users_binding.dart';
import '../modules/admin/views/add_user.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/admin/views/student_detail_view.dart';
import '../modules/admin/views/view_users.dart';
import '../modules/exam/bindings/exam_detail_binding.dart';
import '../modules/exam/views/exam_detail_view.dart';
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
      name: AppRoutes.addUser,
      page: () => AddUserView(),
      binding: AdduserBinding(),
    ),
    GetPage(
      name: AppRoutes.viewUsers,
      page: () => ViewUsersView(),
      binding: ViewUsersBinding(),
    ),
    GetPage(
      name: AppRoutes.studentDetail,
      page: () => StudentDetailView(),
      binding: StudentDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.examDetail,
      page: () => ExamDetailView(),
      binding: ExamDetailBinding(),
    ),
  ];
}

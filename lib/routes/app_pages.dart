import 'package:get/route_manager.dart';
import 'package:mentor_app/modules/admin/bindings/add_subject_binding.dart';
import 'package:mentor_app/modules/admin/bindings/subject_binding.dart';
import 'package:mentor_app/modules/admin/views/add_subject_view.dart';
import 'package:mentor_app/modules/admin/views/subject_list_view.dart';
import 'package:mentor_app/modules/attendence/bindings/attendence_binding.dart';
import 'package:mentor_app/modules/attendence/views/attendence_view.dart';

import '../modules/admin/bindings/add_user_binding.dart';
import '../modules/admin/bindings/view_users_binding.dart';
import '../modules/admin/views/add_user.dart';
import '../modules/admin/views/admin_view.dart';
import '../modules/admin/views/view_users.dart';
import '../modules/exam/bindings/exam_detail_binding.dart';
import '../modules/exam/views/exam_detail_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/student/bindings/student_detail_binding.dart';
import '../modules/student/views/student_detail_view.dart';
import '../modules/teacher/bindings/teacher_detail_binding.dart';
import '../modules/teacher/views/teacher_detail_view.dart';
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
      name: AppRoutes.subjectList,
      page: () => SubjectListView(),
      binding: SubjectBinding(),
    ),
    GetPage(
      name: AppRoutes.addSubject,
      page: () => AddSubjectView(),
      binding: AddSubjectBinding(),
    ),
    GetPage(
      name: AppRoutes.teacherDetail,
      page: () => TeacherDetailView(),
      binding: TeacherDetailBinding(),
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
    GetPage(
      name: AppRoutes.attendence,
      page: () => AttendenceView(),
      binding: AttendenceBinding(),
    ),
  ];
}

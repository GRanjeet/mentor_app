import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/admin/bindings/view_users_binding.dart';
import 'package:mentor_app/modules/admin/controllers/teacher_detail_controller.dart';
import 'package:mentor_app/modules/admin/views/view_users.dart';
import 'package:mentor_app/utils/app_string.dart';

import '../controllers/view_users_controller.dart';

class TeacherDetailView extends GetView<TeacherDetailController> {
  const TeacherDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teacher Details'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: EdgeInsets.all(12),
                child: Column(
                  children: [
                    Card(
                      child: ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.teacherData.value.fullName!),
                            Text(controller.teacherData.value.subject?.name ?? ''),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.teacherData.value.email!),
                                Text(controller.teacherData.value.phone!),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text(AppStrings.viewAllStudent),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () async {
                          await Get.delete<ViewUsersController>();
                          Get.to(
                            () => ViewUsersView(
                              teacherId: controller.teacherData.value.id!,
                              showStudents: true,
                            ),
                            arguments: {
                              'isTeacher': false,
                              'showStudents': true,
                              'teacher': controller.teacherData.value,
                            },
                            binding: ViewUsersBinding(),
                          );
                        },
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('View All Feedbacks'),
                        trailing: Icon(Icons.chevron_right_rounded),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

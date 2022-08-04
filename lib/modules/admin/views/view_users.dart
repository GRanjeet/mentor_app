import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../controllers/view_users_controller.dart';

class ViewUsersView extends GetView<ViewUsersController> {
  final String teacherId;
  final bool showStudents;

  const ViewUsersView({this.teacherId = '', this.showStudents = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isTeacher.value ? 'Teachers List' : 'Students List'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: controller.isTeacher.value
                    ? controller.teachersList.length
                    : controller.studentsList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    tileColor: Colors.white,
                    title: Text(
                      controller.isTeacher.value
                          ? controller.teachersList[index].fullName.toString()
                          : controller.studentsList[index].fullName.toString(),
                    ),
                    subtitle: Text(
                      controller.isTeacher.value
                          ? controller.teachersList[index].email.toString()
                          : controller.studentsList[index].email.toString(),
                    ),
                    trailing: Icon(Icons.chevron_right_rounded),
                    onTap: () {
                      if (showStudents) {
                        Get.toNamed(AppRoutes.studentDetail, arguments: {
                          'studentData': controller.studentsList[index],
                          'isStudent': false,
                        })!
                            .then(
                          (value) => {
                            Get.put(ViewUsersController()),
                            controller.getTeacherStudentsData(teacherId),
                          },
                        );
                      } else if (controller.isTeacher.value) {
                        log(controller.teachersList[index].toJson().toString());
                        Get.toNamed(
                          AppRoutes.teacherDetail,
                          arguments: controller.teachersList[index],
                        )!
                            .then(
                          (value) => {
                            Get.put(ViewUsersController()),
                            controller.getUsersData(),
                          },
                        );
                      } else {
                        Get.toNamed(
                          AppRoutes.studentDetail,
                          arguments: {
                            'studentData': controller.studentsList[index],
                            'isStudent': false,
                          },
                        )!
                            .then(
                          (value) => {
                            Get.put(ViewUsersController()),
                            controller.getUsersData(),
                          },
                        );
                      }
                    },
                  );
                },
                separatorBuilder: (_, index) => Divider(height: 0),
              ),
      ),
    );
  }
}

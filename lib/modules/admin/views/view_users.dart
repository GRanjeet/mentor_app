import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/view_users.controller.dart';
import '../../../routes/app_routes.dart';

class ViewUsersView extends GetView<ViewUsersController> {
  const ViewUsersView({Key? key}) : super(key: key);

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
                      if (controller.isTeacher.value) {
                      } else {
                        Get.toNamed(
                          AppRoutes.studentDetail,
                          arguments: controller.studentsList[index],
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

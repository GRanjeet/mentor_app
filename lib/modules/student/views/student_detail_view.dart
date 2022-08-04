import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/student/views/ask_for_help.dart';
import 'package:mentor_app/modules/student/views/student_performance_view.dart';
import 'package:mentor_app/routes/app_routes.dart';

import '../../admin/views/subject_detail_view.dart';
import '../controllers/student_detail_controller.dart';

class StudentDetailView extends GetView<StudentDetailController> {
  const StudentDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !controller.isStudent.value,
        title: const Text('Student Details'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
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
                            Text(controller.studentData.value.fullName!),
                            Text(controller.studentData.value.address!),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(controller.studentData.value.email!),
                                Text(controller.studentData.value.phone!),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Attendence'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.toNamed(
                          AppRoutes.attendence,
                          arguments: controller.studentData.value,
                        )!
                            .then(
                          (value) => controller.getStudentData(),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Subjects'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(() => SubjectDetailsView())!.then(
                          (value) => controller.getStudentData(),
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Peformance'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () {
                          controller.calculatedPerformance();
                          Get.to(() => StudentPerformanceView())!.then(
                            (value) => controller.getStudentData(),
                          );
                        },
                      ),
                    ),
                    if (controller.isStudent.value)
                      Card(
                        child: ListTile(
                          title: Text('Ask for Help'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          onTap: () => Get.to(AskForHelp()),
                        ),
                      ),
                    if (controller.isStudent.value)
                      Card(
                        child: ListTile(
                          title: Text('Notification'),
                          trailing: Icon(Icons.chevron_right_rounded),
                          onTap: () {},
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}

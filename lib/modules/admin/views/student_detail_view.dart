import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/student_detail_controller.dart';
import 'attendence_details_view.dart';
import 'subject_detail_view.dart';

class StudentDetailView extends GetView<StudentDetailController> {
  const StudentDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                            Text(controller.studentData.value.year!),
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
                            SizedBox(height: 8),
                            Text(controller.studentData.value.address!),
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Attendence'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(() => AttendenceDetailsView()),
                      ),
                    ),
                    Card(
                      child: ListTile(
                        title: Text('Subjects'),
                        trailing: Icon(Icons.chevron_right_rounded),
                        onTap: () => Get.to(() => SubjectDetailsView()),
                      ),
                    ),
                    // Card(
                    //   child: ListTile(
                    //     title: Text('Second Year'),
                    //     trailing: Icon(Icons.chevron_right_rounded),
                    //   ),
                    // ),
                    // Card(
                    //   child: ListTile(
                    //     title: Text('Third Year'),
                    //     trailing: Icon(Icons.chevron_right_rounded),
                    //   ),
                    // ),
                    // Expanded(
                    //   child: ListView.builder(
                    //     shrinkWrap: true,
                    //     itemCount: controller.subjectsList.length,
                    //     itemBuilder: ((context, subIndex) {
                    //       return Column(
                    //         children: [
                    //           ListView.builder(
                    //             shrinkWrap: true,
                    //             physics: ClampingScrollPhysics(),
                    //             itemCount: controller.subjectsList[subIndex].sem!.length,
                    //             itemBuilder: (context, semIndex) {
                    //               return Column(
                    //                 children: [
                    //                   Card(
                    //                     child: ListTile(
                    //                       title: Text(
                    //                         controller.subjectsList[subIndex].sem![semIndex].name!,
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   ListView.builder(
                    //                     shrinkWrap: true,
                    //                     physics: ClampingScrollPhysics(),
                    //                     itemCount: controller
                    //                         .subjectsList[subIndex].sem![semIndex].subList!.length,
                    //                     itemBuilder: (context, semSubIndex) {
                    //                       return Column(
                    //                         children: [
                    //                           Card(
                    //                             child: ListTile(
                    //                               title: Text(controller
                    //                                   .subjectsList[subIndex]
                    //                                   .sem![semIndex]
                    //                                   .subList![semSubIndex]
                    //                                   .subName!),
                    //                             ),
                    //                           ),
                    //                         ],
                    //                       );
                    //                     },
                    //                   )
                    //                 ],
                    //               );
                    //             },
                    //           ),
                    //         ],
                    //       );
                    //     }),
                    //   ),
                    // ),
                  ],
                ),
              ),
      ),
    );
  }
}

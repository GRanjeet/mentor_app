import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';
import '../../student/controllers/student_detail_controller.dart';

class SubjectDetailsView extends StatefulWidget {
  const SubjectDetailsView({Key? key}) : super(key: key);

  @override
  State<SubjectDetailsView> createState() => _SubjectDetailsViewState();
}

class _SubjectDetailsViewState extends State<SubjectDetailsView> {
  final controller = Get.find<StudentDetailController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getSubjectList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subject Detials'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: Colors.white,
                        title: Text('First Year'),
                        trailing: Icon(
                          controller.isFyExpanded.value
                              ? Icons.expand_more_rounded
                              : Icons.chevron_right_rounded,
                        ),
                        onTap: () => controller.isFyExpanded.toggle(),
                      ),
                      Divider(height: 0),
                      if (controller.isFyExpanded.value)
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.fySubjectDataList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => Get.toNamed(
                                AppRoutes.examDetail,
                                arguments: {
                                  'studentId': controller.studentData.value.id,
                                  'subjectCode': controller.fySubjectDataList[index].code,
                                  'subjectName': controller.fySubjectDataList[index].name,
                                },
                              ),
                              visualDensity: VisualDensity.compact,
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.fySubjectDataList[index].name!),
                                  Text('Sem : ${controller.fySubjectDataList[index].sem!}'),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => Divider(height: 0),
                        ),
                      if (controller.isFyExpanded.value) Divider(height: 0),
                      ListTile(
                        tileColor: Colors.white,
                        title: Text('Second Year'),
                        trailing: Icon(
                          controller.isSyExpanded.value
                              ? Icons.expand_more_rounded
                              : Icons.chevron_right_rounded,
                        ),
                        onTap: () => controller.isSyExpanded.toggle(),
                      ),
                      Divider(height: 0),
                      if (controller.isSyExpanded.value)
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.sySubjectDataList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => Get.toNamed(
                                AppRoutes.examDetail,
                                arguments: {
                                  'studentId': controller.studentData.value.id,
                                  'subjectCode': controller.sySubjectDataList[index].code,
                                  'subjectName': controller.sySubjectDataList[index].name,
                                },
                              ),
                              visualDensity: VisualDensity.compact,
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.sySubjectDataList[index].name!),
                                  Text('Sem : ${controller.sySubjectDataList[index].sem!}'),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => Divider(height: 0),
                        ),
                      if (controller.isSyExpanded.value) Divider(height: 0),
                      ListTile(
                        tileColor: Colors.white,
                        title: Text('Third Year'),
                        trailing: Icon(
                          controller.isTyExpanded.value
                              ? Icons.expand_more_rounded
                              : Icons.chevron_right_rounded,
                        ),
                        onTap: () => controller.isTyExpanded.toggle(),
                      ),
                      Divider(height: 0),
                      if (controller.isTyExpanded.value)
                        ListView.separated(
                          shrinkWrap: true,
                          itemCount: controller.tySubjectDataList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () => Get.toNamed(
                                AppRoutes.examDetail,
                                arguments: {
                                  'studentId': controller.studentData.value.id,
                                  'subjectCode': controller.tySubjectDataList[index].code,
                                  'subjectName': controller.tySubjectDataList[index].name,
                                },
                              ),
                              visualDensity: VisualDensity.compact,
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.tySubjectDataList[index].name!),
                                  Text('Sem : ${controller.tySubjectDataList[index].sem!}'),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => Divider(height: 0),
                        ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/admin/controllers/subject_controller.dart';
import 'package:mentor_app/routes/app_routes.dart';
import 'package:mentor_app/utils/app_string.dart';

class SubjectListView extends GetView<SubjectController> {
  const SubjectListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.subjects),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(AppRoutes.addSubject)!.then(
              (value) => controller.getSubjectsList(),
            ),
            icon: Icon(Icons.add_circle_outline_outlined),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: Colors.white,
                        title: Text(
                          'First Year',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
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
                          itemCount: controller.fySubjectsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              visualDensity: VisualDensity.compact,
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.fySubjectsList[index].name!),
                                  Text('Sem : ${controller.fySubjectsList[index].sem!}'),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => Divider(height: 0),
                        ),
                      if (controller.isFyExpanded.value) Divider(height: 0),
                      ListTile(
                        tileColor: Colors.white,
                        title: Text(
                          'Second Year',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
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
                          itemCount: controller.sySubjectsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              visualDensity: VisualDensity.compact,
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.sySubjectsList[index].name!),
                                  Text('Sem : ${controller.sySubjectsList[index].sem!}'),
                                ],
                              ),
                            );
                          },
                          separatorBuilder: (_, index) => Divider(height: 0),
                        ),
                      if (controller.isSyExpanded.value) Divider(height: 0),
                      ListTile(
                        tileColor: Colors.white,
                        title: Text(
                          'Third Year',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
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
                          itemCount: controller.tySubjectsList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              visualDensity: VisualDensity.compact,
                              tileColor: Colors.white,
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.tySubjectsList[index].name!),
                                  Text('Sem : ${controller.tySubjectsList[index].sem!}'),
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

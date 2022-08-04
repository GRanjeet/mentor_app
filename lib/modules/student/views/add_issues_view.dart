import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/student/controllers/student_detail_controller.dart';

import '../../admin/models/subject_model.dart';

class AddIssuesView extends StatelessWidget {
  const AddIssuesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentDetailController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Need Help'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: controller.issueFormKey,
                  child: Container(
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Obx(
                          () => Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              DropdownButtonFormField<String>(
                                value: controller.selectedType.value.isEmpty
                                    ? null
                                    : controller.selectedType.value,
                                hint: Text('To'),
                                isDense: true,
                                onChanged: (value) => controller.selectedType.value = value!,
                                validator: (value) => value == null ? 'Required*' : null,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                items: controller.typeList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                              if (controller.selectedType.value == 'Teacher') SizedBox(height: 16),
                              if (controller.selectedType.value == 'Teacher')
                                DropdownButtonFormField<SubjectModel>(
                                  value: controller.selectedSubject.value.name == null
                                      ? null
                                      : controller.selectedSubject.value,
                                  hint: Text('Subject'),
                                  isDense: true,
                                  onChanged: (value) => controller.selectedSubject.value = value!,
                                  validator: (value) => value == null ? 'Required*' : null,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  items: controller.allSubjectDataList.map((SubjectModel value) {
                                    return DropdownMenuItem<SubjectModel>(
                                      value: value,
                                      child: Text(value.name!),
                                    );
                                  }).toList(),
                                ),
                              if (controller.selectedType.value == 'Advisor') SizedBox(height: 16),
                              if (controller.selectedType.value == 'Advisor')
                                DropdownButtonFormField<String>(
                                  value: controller.selectedIssueType.value.isEmpty
                                      ? null
                                      : controller.selectedIssueType.value,
                                  hint: Text('Issue'),
                                  isDense: true,
                                  onChanged: (value) => controller.selectedIssueType.value = value!,
                                  validator: (value) => value == null ? 'Required*' : null,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  items: controller.issueTypeList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: controller.titleTextController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: 'Title',
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) return '*Requird';
                                  return null;
                                },
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: controller.msgTextController,
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(
                                  hintText: 'Message',
                                  contentPadding: EdgeInsets.all(16),
                                ),
                                validator: (value) {
                                  if (value!.isEmpty) return '*Requird';
                                  return null;
                                },
                                maxLines: 10,
                              ),
                              SizedBox(height: 16),
                              Container(
                                width: double.infinity,
                                height: 46,
                                child: ElevatedButton(
                                  onPressed: controller.addIssue,
                                  child: Text('Add'),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

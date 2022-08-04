import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../admin/models/subject_model.dart';
import '../controllers/attendence_controller.dart';

class AddAttendenceView extends GetView<AttendenceController> {
  const AddAttendenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Attendence'),
      ),
      body: Obx(
        () => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Container(
                    margin: EdgeInsets.all(16),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        DropdownButtonFormField<SubjectModel>(
                          value: controller.selectedSubject.value.name == null
                              ? null
                              : controller.selectedSubject.value,
                          hint: Text('Subject'),
                          isDense: true,
                          onChanged: (value) => controller.selectedSubject.value = value!,
                          validator: (value) => value == null ? 'Required*' : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: controller.subjectsList.map((SubjectModel value) {
                            return DropdownMenuItem<SubjectModel>(
                              value: value,
                              child: Text(value.name!),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: controller.present.value.isEmpty ? null : controller.present.value,
                          hint: Text('Present'),
                          isDense: true,
                          onChanged: (value) => controller.present.value = value!,
                          validator: (value) => value == null ? 'Required*' : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: controller.presentList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16),
                        DropdownButtonFormField<String>(
                          value: controller.selectedClassType.value.isEmpty
                              ? null
                              : controller.selectedClassType.value,
                          hint: Text('Type'),
                          isDense: true,
                          onChanged: (value) => controller.selectedClassType.value = value!,
                          validator: (value) => value == null ? 'Required*' : null,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          items: controller.classTypeList.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                        ),
                        SizedBox(height: 16),
                        InkWell(
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021, 1),
                              lastDate: DateTime(2025, 12),
                            ).then((pickedDate) {
                              if (pickedDate != null) {
                                var date = DateFormat('dd-MM-yyyy').format(pickedDate);
                                controller.selectedtDate.value = date;
                                controller.dateTextController.text = date;
                              }
                            });
                          },
                          child: AbsorbPointer(
                            absorbing: true,
                            child: TextFormField(
                              controller: controller.dateTextController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: 'Date',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) return 'Required*';
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((pickedTime) {
                                    if (pickedTime != null) {
                                      var time = pickedTime.format(context);
                                      controller.selectedtStartTime.value = time;
                                      controller.startTimeTextController.text = time;
                                      log(pickedTime.toString());
                                    }
                                  });
                                },
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: TextFormField(
                                    controller: controller.startTimeTextController,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      hintText: 'Start Time',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) return 'Required*';
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((pickedTime) {
                                    if (pickedTime != null) {
                                      var time = pickedTime.format(context);
                                      controller.selectedtEndTime.value = time;
                                      controller.endTimeTextController.text = time;
                                      log(pickedTime.toString());
                                    }
                                  });
                                },
                                child: AbsorbPointer(
                                  absorbing: true,
                                  child: TextFormField(
                                    controller: controller.endTimeTextController,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    decoration: InputDecoration(
                                      hintText: 'End Time',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) return 'Required*';
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Container(
                          width: double.infinity,
                          height: 46,
                          child: ElevatedButton(
                            onPressed: () => controller.addAttendence(),
                            child: Text('Add'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}

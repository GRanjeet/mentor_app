import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/app_string.dart';
import '../controllers/add_user_controller.dart';
import '../models/subject_model.dart';

class AddUserView extends GetView<AddUserController> {
  const AddUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.isTeacher.value ? AppStrings.addTeacher : AppStrings.addStudent),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Form(
                  key: controller.formKey,
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller.fullNameTextController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Required*';
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: controller.phoneTextController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Phone No.',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Required*';
                              if (!value.isPhoneNumber) return 'Enter valid Phone No.*';
                              return null;
                            },
                          ),
                          if (controller.isTeacher.value)
                            CheckboxListTile(
                              value: controller.isStudyAdvisor.value,
                              controlAffinity: ListTileControlAffinity.leading,
                              title: Text('Study Advisor'),
                              contentPadding: EdgeInsets.zero,
                              onChanged: (value) => controller.isStudyAdvisor.toggle(),
                            ),
                          if (!controller.isTeacher.value) SizedBox(height: 16),
                          if (!controller.isTeacher.value)
                            TextFormField(
                              controller: controller.addressTextController,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: 'Address',
                              ),
                              validator: (value) {
                                if (value!.isEmpty) return 'Required*';
                                return null;
                              },
                            ),
                          if (!controller.isTeacher.value) SizedBox(height: 16),
                          if (!controller.isTeacher.value)
                            DropdownButtonFormField<String>(
                              value: controller.selectedClass.value.isEmpty
                                  ? null
                                  : controller.selectedClass.value,
                              isDense: true,
                              hint: Text('Class'),
                              onChanged: (value) => controller.selectedClass.value = value!,
                              validator: (value) => value == null ? 'Required*' : null,
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              items: controller.classList.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          if (controller.isTeacher.value && !controller.isStudyAdvisor.value)
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
                          if (controller.isTeacher.value && !controller.isStudyAdvisor.value)
                            SizedBox(height: 16),
                          if (!controller.isTeacher.value) SizedBox(height: 16),
                          TextFormField(
                            controller: controller.emailTextController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'Email ID',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Required*';
                              if (!value.isEmail) return 'Enter valid Email ID!';
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: controller.passwordTextController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Required*';
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () => controller.addUser(),
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
    );
  }
}

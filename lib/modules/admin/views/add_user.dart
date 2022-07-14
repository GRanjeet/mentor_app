import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/add_user_controller.dart';
import '../../../utils/app_string.dart';

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
                child: Container(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller.fullNameTextController,
                            decoration: InputDecoration(
                              hintText: 'Full Name',
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: controller.phoneTextController,
                            decoration: InputDecoration(
                              hintText: 'Phone No.',
                            ),
                          ),
                          SizedBox(height: 16),
                          if (!controller.isTeacher.value)
                            TextFormField(
                              controller: controller.addressTextController,
                              decoration: InputDecoration(
                                hintText: 'Address',
                              ),
                            ),
                          if (!controller.isTeacher.value) SizedBox(height: 16),
                          if (!controller.isTeacher.value)
                            TextFormField(
                              controller: controller.classTextController,
                              decoration: InputDecoration(
                                hintText: 'Class',
                              ),
                            ),
                          if (!controller.isTeacher.value) SizedBox(height: 16),
                          TextFormField(
                            controller: controller.emailTextController,
                            decoration: InputDecoration(
                              hintText: 'Email ID',
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: controller.passwordTextController,
                            decoration: InputDecoration(
                              hintText: 'Password',
                            ),
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

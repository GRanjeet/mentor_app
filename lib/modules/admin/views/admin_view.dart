import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/routes/app_routes.dart';
import 'package:mentor_app/utils/app_string.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.admin),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text(AppStrings.addTeacher),
                trailing: Icon(Icons.chevron_right_rounded),
                onTap: () => Get.toNamed(AppRoutes.addTeacherRoute),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(AppStrings.addStudent),
                trailing: Icon(Icons.chevron_right_rounded),
                onTap: () => Get.toNamed(AppRoutes.addStudentRoute),
              ),
            )
          ],
        ),
      ),
    );
  }
}

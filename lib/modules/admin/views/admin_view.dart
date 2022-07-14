import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../../../utils/app_string.dart';

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
                title: Text(AppStrings.viewAllTeacher),
                trailing: Icon(Icons.chevron_right_rounded),
                onTap: () => Get.toNamed(
                  AppRoutes.viewUsers,
                  arguments: true,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(AppStrings.viewAllStudent),
                trailing: Icon(Icons.chevron_right_rounded),
                onTap: () => Get.toNamed(
                  AppRoutes.viewUsers,
                  arguments: false,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(AppStrings.addTeacher),
                trailing: Icon(Icons.chevron_right_rounded),
                onTap: () => Get.toNamed(
                  AppRoutes.addUser,
                  arguments: true,
                ),
              ),
            ),
            Card(
              child: ListTile(
                title: Text(AppStrings.addStudent),
                trailing: Icon(Icons.chevron_right_rounded),
                onTap: () => Get.toNamed(
                  AppRoutes.addUser,
                  arguments: false,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

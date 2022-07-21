import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mentor_app/modules/admin/controllers/subject_controller.dart';
import 'package:mentor_app/modules/admin/models/subject_model.dart';
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
            onPressed: () {},
            icon: Icon(Icons.add_circle_outline_outlined),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.separated(
                  itemCount: controller.subjectsList.length,
                  itemBuilder: (context, index) {
                    SubjectModel sub = controller.subjectsList[index];
                    return ListTile(
                      tileColor: Colors.white,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(sub.name!),
                          Text(sub.code!),
                        ],
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Year : ' + sub.year!),
                          Text('Sem : ' + sub.sem!),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(height: 0, thickness: 1);
                  },
                ),
              ),
      ),
    );
  }
}

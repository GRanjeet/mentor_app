import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/exam/views/add_exam_view.dart';

import '../../../widgets/custom_loader_widget.dart';
import '../controllers/exam_detail_controller.dart';

class ExamDetailView extends GetView<ExamDetailController> {
  const ExamDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Details'),
        actions: [
          IconButton(
            onPressed: () => Get.to(() => AddExamView())?.then(
              (value) => controller.getExamList(),
            ),
            icon: Icon(Icons.add),
          )
        ],
      ),
      body: Obx(
        () => controller.isLoading
            ? CustomLoaderWidget()
            : SingleChildScrollView(
                child: Container(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: controller.examList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        visualDensity: VisualDensity.compact,
                        tileColor: Colors.white,
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.examList[index].examName!),
                            Text(
                              '${controller.examList[index].scored!} / ${controller.examList[index].total}',
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => Divider(height: 0),
                  ),
                ),
              ),
      ),
    );
  }
}

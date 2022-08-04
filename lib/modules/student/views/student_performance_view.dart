import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/student/controllers/student_detail_controller.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StudentPerformanceView extends StatelessWidget {
  const StudentPerformanceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentDetailController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Performance'),
      ),
      body: Obx(
        () => Card(
          margin: EdgeInsets.all(8),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Attendance Performance :'),
                SizedBox(height: 8),
                LinearPercentIndicator(
                  lineHeight: 14.0,
                  percent: controller.attPercentage.value,
                  trailing: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text('${(controller.attPercentage.value * 100).toStringAsFixed(0)}%'),
                  ),
                  padding: EdgeInsets.zero,
                  barRadius: Radius.circular(8),
                  backgroundColor: Colors.grey.shade100,
                  progressColor: controller.currentProgressColor(
                    controller.attPercentage.value,
                  ),
                ),
                SizedBox(height: 16),
                Text('Exam Performance :'),
                SizedBox(height: 8),
                LinearPercentIndicator(
                  lineHeight: 14.0,
                  percent: controller.examPercentage.value,
                  trailing: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text('${(controller.examPercentage.value * 100).toStringAsFixed(0)}%'),
                  ),
                  padding: EdgeInsets.zero,
                  barRadius: Radius.circular(8),
                  backgroundColor: Colors.grey.shade100,
                  progressColor: controller.currentProgressColor(
                    controller.examPercentage.value,
                  ),
                ),
                SizedBox(height: 16),
                Text('Overall Performance :'),
                SizedBox(height: 8),
                LinearPercentIndicator(
                  lineHeight: 14.0,
                  percent: controller.overPercentage.value,
                  trailing: Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text('${(controller.overPercentage.value * 100).toStringAsFixed(0)}%'),
                  ),
                  padding: EdgeInsets.zero,
                  barRadius: Radius.circular(8),
                  backgroundColor: Colors.grey.shade100,
                  progressColor: controller.currentProgressColor(
                    controller.overPercentage.value,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

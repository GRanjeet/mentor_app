import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/attendence/controllers/attendence_controller.dart';
import 'package:mentor_app/modules/attendence/views/add_attendence_view.dart';
import 'package:mentor_app/modules/student/controllers/student_detail_controller.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendenceView extends GetView<AttendenceController> {
  const AttendenceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final studentController = Get.find<StudentDetailController>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Attendence Details'),
        actions: [
          !studentController.isStudent.value
              ? IconButton(
                  onPressed: () => Get.to(() => AddAttendenceView())!.then(
                    (value) => controller.getStudentData(),
                  ),
                  icon: Icon(Icons.add),
                )
              : SizedBox(),
        ],
      ),
      body: Obx(
        () => controller.isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                child: Column(
                  children: [
                    TableCalendar(
                      rowHeight: 42,
                      firstDay: DateTime.utc(2010),
                      lastDay: DateTime.now(),
                      focusedDay: controller.calSelectedDate.value,
                      currentDay: controller.calSelectedDate.value,
                      onDaySelected: (selectedDay, _) =>
                          controller.loadSelectedDateList(selectedDay),
                    ),
                    Divider(thickness: 2),
                    Expanded(
                      child: ListView.separated(
                        itemCount: controller.selectedDateAttendenceList.length,
                        itemBuilder: (context, index) {
                          var att = controller.selectedDateAttendenceList[index];
                          return ListTile(
                            visualDensity: VisualDensity.compact,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(att.subject!.name!),
                                Text(att.classType!),
                              ],
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(att.isPresent! ? 'Present' : 'Absent'),
                                Text('${att.startTime} to ${att.endTime}'),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider(thickness: 1, height: 16);
                        },
                      ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}

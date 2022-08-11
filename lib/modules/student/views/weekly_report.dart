import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/student/controllers/student_detail_controller.dart';

class WeeklyReport extends StatefulWidget {
  final bool showDialog;

  const WeeklyReport({
    Key? key,
    this.showDialog = false,
  }) : super(key: key);

  @override
  State<WeeklyReport> createState() => _WeeklyReportState();
}

class _WeeklyReportState extends State<WeeklyReport> {
  final controller = Get.find<StudentDetailController>();

  @override
  void initState() {
    super.initState();
    if (widget.showDialog)
      WidgetsBinding.instance.addPostFrameCallback(
        (_) => controller.showWeeklyDialog(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

class WeeklyDialog extends StatelessWidget {
  const WeeklyDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentDetailController>();

    return Form(
      key: controller.reportFormKey,
      child: AlertDialog(
        elevation: 2,
        contentPadding: EdgeInsets.all(8),
        insetPadding: EdgeInsets.all(16),
        content: Card(
          elevation: 0,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Weekly Progress',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text('How was you last week?'),
                      ],
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.close,
                      ),
                    ),
                  ],
                ),
                Divider(thickness: 1, height: 24),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Health',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: controller.selectedRating1.value.isEmpty
                                ? null
                                : controller.selectedRating1.value,
                            hint: Text('Rating'),
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                            ),
                            onChanged: (value) => controller.selectedRating1.value = value!,
                            validator: (value) => value == null ? 'Required*' : null,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            items: controller.ratingList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Behaviour',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: controller.selectedRating2.value.isEmpty
                                ? null
                                : controller.selectedRating2.value,
                            hint: Text('Rating'),
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                            ),
                            onChanged: (value) => controller.selectedRating2.value = value!,
                            validator: (value) => value == null ? 'Required*' : null,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            items: controller.ratingList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reading',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: controller.selectedRating3.value.isEmpty
                                ? null
                                : controller.selectedRating3.value,
                            hint: Text('Rating'),
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                            ),
                            onChanged: (value) => controller.selectedRating3.value = value!,
                            validator: (value) => value == null ? 'Required*' : null,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            items: controller.ratingList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Writing',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: controller.selectedRating4.value.isEmpty
                                ? null
                                : controller.selectedRating4.value,
                            hint: Text('Rating'),
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                            ),
                            onChanged: (value) => controller.selectedRating4.value = value!,
                            validator: (value) => value == null ? 'Required*' : null,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            items: controller.ratingList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Work Habit',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: controller.selectedRating5.value.isEmpty
                                ? null
                                : controller.selectedRating5.value,
                            hint: Text('Rating'),
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                            ),
                            onChanged: (value) => controller.selectedRating5.value = value!,
                            validator: (value) => value == null ? 'Required*' : null,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            items: controller.ratingList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Social Habit',
                            style: TextStyle(
                              color: Colors.green,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(height: 6),
                          DropdownButtonFormField<String>(
                            value: controller.selectedRating6.value.isEmpty
                                ? null
                                : controller.selectedRating6.value,
                            hint: Text('Rating'),
                            isDense: true,
                            isExpanded: true,
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 0,
                              ),
                            ),
                            onChanged: (value) => controller.selectedRating6.value = value!,
                            validator: (value) => value == null ? 'Required*' : null,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            items: controller.ratingList.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  height: 42,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.saveWeeklyReportData,
                    child: Text('Save'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RatingFeild extends StatelessWidget {
  final String? label;
  final String? selectedValue;

  const RatingFeild({
    Key? key,
    this.label,
    this.selectedValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentDetailController>();
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label ?? 'Label',
            style: TextStyle(
              color: Colors.green,
              fontSize: 16,
            ),
          ),
          SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: controller.selectedIssueType.value.isEmpty
                ? null
                : controller.selectedIssueType.value,
            hint: Text('Rating'),
            isDense: true,
            isExpanded: true,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 0,
              ),
            ),
            onChanged: (value) => controller.selectedIssueType.value = value!,
            validator: (value) => value == null ? 'Required*' : null,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            items: controller.ratingList.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

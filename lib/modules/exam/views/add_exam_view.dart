import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/exam/controllers/exam_detail_controller.dart';
import 'package:mentor_app/widgets/custom_loader_widget.dart';

class AddExamView extends StatelessWidget {
  const AddExamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ExamDetailController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Exam Detail'),
      ),
      body: Obx(
        () => controller.isLoading
            ? CustomLoaderWidget()
            : Form(
                key: controller.formkey,
                child: Container(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller.examNameTextController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'Exam Name',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Required';
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.scoredTextController,
                                  keyboardType: TextInputType.number,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    hintText: 'Scored',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) return 'Required';
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: TextFormField(
                                  controller: controller.totalTextController,
                                  keyboardType: TextInputType.number,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    hintText: 'Total',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) return 'Required';
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: controller.feedbackController,
                            decoration: InputDecoration(
                              hintText: 'Remark',
                            ),
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () => controller.addExamDetail(),
                              child: Text('Add Exam'),
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

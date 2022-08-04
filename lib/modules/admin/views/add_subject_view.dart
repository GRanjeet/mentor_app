import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_loader_widget.dart';
import '../controllers/add_subject_controller.dart';

class AddSubjectView extends GetView<AddSubjectController> {
  const AddSubjectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Subject'),
      ),
      body: Obx(
        () => controller.isLoading
            ? CustomLoaderWidget()
            : Form(
                key: controller.formKey,
                child: Container(
                  child: Card(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Container(
                      margin: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: controller.nameTextController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'Name er. Maths',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) return 'Required';
                              return null;
                            },
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: controller.codeTextController,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            decoration: InputDecoration(
                              hintText: 'Code eg. FY0101',
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
                                child: DropdownButtonFormField<String>(
                                  value: controller.yearTextController.text.isBlank!
                                      ? null
                                      : controller.yearTextController.text,
                                  isDense: true,
                                  hint: Text('Class'),
                                  onChanged: (value) => controller.yearTextController.text = value!,
                                  validator: (value) => value == null ? 'Required*' : null,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  items: controller.yearList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: DropdownButtonFormField<String>(
                                  value: controller.semTextController.text.isBlank!
                                      ? null
                                      : controller.semTextController.text,
                                  isDense: true,
                                  hint: Text('Class'),
                                  onChanged: (value) => controller.semTextController.text = value!,
                                  validator: (value) => value == null ? 'Required*' : null,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  items: controller.semList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(' Sem $value'),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          Container(
                            width: double.infinity,
                            height: 46,
                            child: ElevatedButton(
                              onPressed: controller.addSubject,
                              child: Text('Add Subject'),
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

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/admin/models/subject_model.dart';

class AddSubjectController extends GetxController {
  final _db = FirebaseFirestore.instance.collection('subjects');

  final _isLoading = false.obs;
  get isLoading => this._isLoading.value;

  final formKey = GlobalKey<FormState>();
  final nameTextController = TextEditingController();
  final codeTextController = TextEditingController();
  final semTextController = TextEditingController();
  final yearTextController = TextEditingController();

  final semList = ['1', '2', '3', '4', '5', '6'];
  final yearList = ['FY', 'SY', 'TY'];

  void addSubject() async {
    if (formKey.currentState!.validate()) {
      _isLoading.value = true;

      var data = SubjectModel(
        name: nameTextController.text.trim(),
        code: codeTextController.text.trim(),
        year: yearTextController.text.trim(),
        sem: semTextController.text.trim(),
      ).toJson();

      log(data.toString());

      await _db.add(data).then(
            (value) => {
              log('Subject Added'),
              Get.back(),
              Get.rawSnackbar(
                title: 'Success',
                message: "Subject added  successfully",
                backgroundColor: Colors.green,
              )
            },
          );
      _isLoading.value = false;
    }
  }
}

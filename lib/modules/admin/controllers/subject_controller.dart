import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/subject_model.dart';

class SubjectController extends GetxController {
  final _isLoading = false.obs;
  get isLoading => this._isLoading.value;

  final subjectsList = <SubjectModel>[].obs;

  @override
  void onInit() {
    getSubjectsList();
    super.onInit();
  }

  void getSubjectsList() async {
    _isLoading.value = true;

    log('Getting subjects list...');
    final _db = FirebaseFirestore.instance.collection('subjects');
    try {
      await _db.get().then((value) {
        value.docs.forEach((doc) {
          var data = doc.data();
          log(jsonEncode(data).toString());
          subjectsList.add(SubjectModel.fromJson(data));
        });
      });
    } catch (e) {
      log(e.toString());
    }

    _isLoading.value = false;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../models/student_model.dart';
import '../models/teacher_model.dart';

class ViewUsersController extends GetxController {
  final isLoading = false.obs;
  final isTeacher = false.obs;
  var teachersList = <TeacherModel>[].obs;
  var studentsList = <StudentModel>[].obs;

  @override
  void onInit() {
    isTeacher.value = Get.arguments;
    getData();
    super.onInit();
  }

  void getData() async {
    isLoading.value = true;
    await FirebaseFirestore.instance
        .collection(isTeacher.value ? 'teachers' : 'students')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var data = doc.data() as Map<String, dynamic>;
        if (isTeacher.value) {
          teachersList.add(TeacherModel.fromJson(data));
        } else {
          studentsList.add(StudentModel.fromJson(data));
        }
      });
    });
    isLoading.value = false;
  }
}

import 'package:flutter/material.dart';
import '../../utils/app_string.dart';

class TeacherView extends StatelessWidget {
  const TeacherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.teacher),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('View Students'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('Add Student'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

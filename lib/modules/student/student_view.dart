import 'package:flutter/material.dart';
import '../../utils/app_string.dart';

class StudentView extends StatelessWidget {
  const StudentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(AppStrings.student),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('View Subjects'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('View Attendance'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            ),
            Card(
              child: ListTile(
                title: Text('View Notifications'),
                trailing: Icon(Icons.chevron_right_rounded),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

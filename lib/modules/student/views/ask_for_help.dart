import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/student/controllers/student_detail_controller.dart';
import 'package:mentor_app/modules/student/views/add_issues_view.dart';

class AskForHelp extends StatelessWidget {
  const AskForHelp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<StudentDetailController>();
    return Scaffold(
      appBar: AppBar(
        title: Text('Ask for Help'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => Get.to(AddIssuesView())!.then(
              (value) => controller.getIssuesList(),
            ),
          ),
        ],
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : controller.issueList.isEmpty
                ? Center(child: Text('No Data Found'))
                : ListView.separated(
                    itemCount: controller.issueList.length,
                    itemBuilder: (_, index) {
                      var issue = controller.issueList[index];
                      return ListTile(
                        visualDensity: VisualDensity.comfortable,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        tileColor: Colors.white,
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                issue.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.all(6),
                              alignment: Alignment.centerRight,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: issue.forAdvisor!
                                    ? Colors.blue.withOpacity(0.1)
                                    : Colors.green.withOpacity(0.1),
                              ),
                              child: Text(
                                issue.forAdvisor! ? 'Advisor' : 'Teacher',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: issue.forAdvisor! ? Colors.blue : Colors.green,
                                ),
                              ),
                            ),
                          ],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 12),
                              child: Text(
                                issue.msg ?? '-',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  issue.forAdvisor! ? issue.issueType! : issue.subject!.name ?? '-',
                                ),
                                Text(issue.createdAt ?? '-'),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (_, index) => Divider(thickness: 1, height: 0),
                  ),
      ),
    );
  }
}

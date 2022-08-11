import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/teacher/controllers/teacher_detail_controller.dart';
import 'package:mentor_app/modules/teacher/views/issue_detail_view.dart';

class FeedbackView extends GetView<TeacherDetailController> {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issues/Help'),
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
                        onTap: () {
                          controller.selectedIssue.value = issue;
                          controller.updateIssueStatus();
                          controller.getStudentDetails();
                          Get.to(() => IssueDetailView());
                        },
                        visualDensity: VisualDensity.comfortable,
                        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        tileColor: Colors.white,
                        title: Row(
                          children: [
                            Expanded(
                              child: Text(
                                issue.issue!.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
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
                                issue.issue!.msg ?? '-',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  issue.issue!.forAdvisor!
                                      ? issue.issue!.issueType!
                                      : issue.issue!.subject!.name ?? '-',
                                ),
                                Text(issue.issue!.createdAt ?? '-'),
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

import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:mentor_app/modules/teacher/controllers/teacher_detail_controller.dart';

class IssueDetailView extends GetView<TeacherDetailController> {
  const IssueDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.chatList.bindStream(controller.chatsStream());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(controller.studentData.value.fullName!),
                        Text(controller.studentData.value.address!),
                      ],
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(controller.studentData.value.email!),
                            Text(controller.studentData.value.phone!),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(controller.studentData.value.year!),
                      ],
                    ),
                  ),
                  Divider(height: 0, thickness: 1),
                  ListTile(
                    visualDensity: VisualDensity.comfortable,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    tileColor: Colors.white,
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            controller.selectedIssue.value.issue!.title ?? '',
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
                            controller.selectedIssue.value.issue!.msg ?? '-',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.selectedIssue.value.issue!.forAdvisor!
                                  ? controller.selectedIssue.value.issue!.issueType!
                                  : controller.selectedIssue.value.issue!.subject!.name ?? '-',
                            ),
                            Text(controller.selectedIssue.value.issue!.createdAt ?? '-'),
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(height: 0, thickness: 1),
                  Obx(
                    () => Expanded(
                      child: ListView.builder(
                        itemCount: controller.chatList.length,
                        itemBuilder: (context, index) {
                          var chat = controller.chatList[index];
                          return chat.msg!.isEmpty
                              ? SizedBox()
                              : BubbleSpecialOne(
                                  text: chat.msg!,
                                  isSender: !chat.isMe!,
                                  color: chat.isMe! ? Colors.green : Colors.blue,
                                  textStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: controller.msgTextController,
                      decoration: InputDecoration(
                        hintText: 'Enter you message',
                        suffixIcon: IconButton(
                          onPressed: controller.sendChat,
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/student/views/help_view.dart';
import 'package:mentor_app/modules/student/views/weekly_report.dart';
import 'package:mentor_app/modules/teacher/views/feedback_view.dart';
import 'package:mentor_app/routes/app_routes.dart';
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@drawable/ic_launcher');

    IOSInitializationSettings iosInitializationSettings = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _localNotificationService.initialize(
      settings,
      onSelectNotification: onSelectNotification,
    );
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );

    const IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(
      id,
      title,
      body,
      details,
      payload: payload,
    );
  }

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) {
    log('Notificatio ID $id');
  }

  void onSelectNotification(String? payload) {
    log('Payload : $payload');
    if (payload != null || payload!.isNotEmpty) {
      if (payload == NotificationKeys.attendenceKey) {
        Get.toNamed(AppRoutes.attendence);
      } else if (payload == NotificationKeys.issueKey) {
        Get.to(() => FeedbackView());
      } else if (payload == NotificationKeys.helpKey) {
        Get.to(() => HelpView());
      } else if (payload == NotificationKeys.weeklyKey) {
        Get.to(() => WeeklyReport(showDialog: true));
      }
    }
  }
}

class NotificationKeys {
  static String attendenceKey = 'AttendenceKey';
  static String issueKey = 'IssueKey';
  static String helpKey = 'HelpKey';
  static String weeklyKey = 'WeeklyKey';
}

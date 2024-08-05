import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:reminder/reminder/data/model/reminder.dart';

abstract class ReminderRepository {
  Future<void> addReminder(Reminder reminder);
  Future<void> updateReminder(Reminder reminder);
  Future<void> deleteReminder(Reminder reminder);
  Future<List<Reminder>> getReminders();
  Future<void> deleteAllReminders();
  ValueListenable<Box<Reminder>> listenToReminders();
}

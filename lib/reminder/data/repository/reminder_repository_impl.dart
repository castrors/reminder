import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder/reminder/data/model/reminder.dart';
import 'package:reminder/reminder/data/repository/reminder_repository.dart';

class ReminderRepositoryImpl implements ReminderRepository {
  ReminderRepositoryImpl(this.box);
  Box<Reminder> box;

  @override
  Future<void> addReminder(Reminder reminder) async {
    await box.add(reminder);
  }

  @override
  Future<void> deleteReminder(Reminder reminder) async {
    await box.delete(reminder.key);
  }

  @override
  Future<List<Reminder>> getReminders() async {
    return box.values.toList();
  }

  @override
  Future<void> updateReminder(Reminder reminder) async {
    await box.put(reminder.key, reminder);
  }

  @override
  Future<void> deleteAllReminders() {
    return box.clear();
  }

  @override
  ValueListenable<Box<Reminder>> listenToReminders() {
    return box.listenable();
  }
}

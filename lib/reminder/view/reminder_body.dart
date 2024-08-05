import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:reminder/edit_reminder/view/edit_reminder_page.dart';
import 'package:reminder/injector.dart';

import 'package:reminder/reminder/data/model/reminder.dart';
import 'package:reminder/reminder/data/repository/reminder_repository.dart';

class ReminderBody extends StatelessWidget {
  const ReminderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<Reminder>>(
      valueListenable: getIt<ReminderRepository>().listenToReminders(),
      builder: (context, box, _) {
        final reminders = box.values.toList();
        if (reminders.isEmpty) {
          return const Center(child: Text('No reminders'));
        } else {
          return ListView.separated(
            separatorBuilder: (context, index) => const Divider(),
            itemCount: reminders.length,
            itemBuilder: (context, index) {
              final reminder = reminders[index];
              return ListTile(
                title: Text(reminder.title),
                subtitle: Text(reminder.description),
                onTap: () => EditReminderPage.show(context, reminder: reminder),
              );
            },
          );
        }
      },
    );
  }
}

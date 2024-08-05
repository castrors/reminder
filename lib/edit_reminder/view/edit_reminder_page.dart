import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/edit_reminder/cubit/edit_reminder_cubit.dart';
import 'package:reminder/edit_reminder/view/date_and_timer_picker.dart';
import 'package:reminder/injector.dart';

import 'package:reminder/reminder/data/model/reminder.dart';

class EditReminderPage extends StatelessWidget {
  const EditReminderPage({super.key, this.reminder});
  final Reminder? reminder;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditReminderCubit(getIt()),
      child: EditReminderView(reminder: reminder),
    );
  }

  static Future<void> show(BuildContext context, {Reminder? reminder}) {
    return Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => EditReminderPage(reminder: reminder),
      ),
    );
  }
}

class EditReminderView extends StatefulWidget {
  const EditReminderView({super.key, this.reminder});
  final Reminder? reminder;

  @override
  State<EditReminderView> createState() => _EditReminderViewState();

  static Future<void> show(BuildContext context, {Reminder? reminder}) {
    return showDialog(
      context: context,
      builder: (_) => EditReminderView(reminder: reminder),
    );
  }
}

class _EditReminderViewState extends State<EditReminderView> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.reminder?.title);
    _descriptionController =
        TextEditingController(text: widget.reminder?.description);
    _date = widget.reminder?.date ?? DateTime.now();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageTitle =
        widget.reminder == null ? 'Add Reminder' : 'Edit Reminder';
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        actions: [
          if (widget.reminder != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                context
                    .read<EditReminderCubit>()
                    .deleteReminder(widget.reminder!);
                Navigator.of(context).pop();
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            const SizedBox(height: 16),
            DateTimePicker(
              initialDateTime: widget.reminder?.date,
              onDateTimeChanged: (dateTime) {
                setState(() {
                  _date = dateTime;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final reminder = widget.reminder;
          if (reminder == null) {
            final newReminder = Reminder(
              title: _titleController.text,
              description: _descriptionController.text,
              date: _date,
            );
            context.read<EditReminderCubit>().addReminder(newReminder);
          } else {
            final newReminder = reminder
              ..date = _date
              ..description = _descriptionController.text
              ..title = _titleController.text;

            context.read<EditReminderCubit>().updateReminder(newReminder);
          }

          Navigator.of(context).pop(reminder);
        },
        child: const Icon(Icons.save),
      ),
    );
  }
}

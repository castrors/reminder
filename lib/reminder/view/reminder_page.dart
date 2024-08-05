import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder/edit_reminder/view/edit_reminder_page.dart';
import 'package:reminder/injector.dart';
import 'package:reminder/reminder/bloc/reminder_bloc.dart';
import 'package:reminder/reminder/data/repository/reminder_repository.dart';
import 'package:reminder/reminder/view/reminder_body.dart';

class ReminderPage extends StatelessWidget {
  const ReminderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReminderBloc(getIt<ReminderRepository>())
        ..add(const RemindersRequested()),
      child: const ReminderView(),
    );
  }
}

class ReminderView extends StatelessWidget {
  const ReminderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reminder')),
      body: const ReminderBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          EditReminderPage.show(context).then((value) {
            context.read<ReminderBloc>().add(const RemindersRequested());
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:reminder/reminder/data/model/reminder.dart';
import 'package:reminder/reminder/data/repository/reminder_repository.dart';
import 'package:reminder/reminder/data/repository/reminder_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  final box = await Hive.openBox<Reminder>('reminders');

  getIt.registerSingleton<ReminderRepository>(ReminderRepositoryImpl(box));
}

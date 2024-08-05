part of 'reminder_bloc.dart';

sealed class ReminderEvent extends Equatable {
  const ReminderEvent();

  @override
  List<Object> get props => [];
}

final class RemindersRequested extends ReminderEvent {
  const RemindersRequested();
}

final class ReminderAdded extends ReminderEvent {
  const ReminderAdded(this.reminder);
  final Reminder reminder;

  @override
  List<Object> get props => [reminder];
}

final class ReminderUpdated extends ReminderEvent {
  const ReminderUpdated(this.reminder);
  final Reminder reminder;

  @override
  List<Object> get props => [reminder];
}

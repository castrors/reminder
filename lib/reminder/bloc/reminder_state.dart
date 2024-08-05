part of 'reminder_bloc.dart';

enum ReminderStatus {
  initial,
  loading,
  loaded,
  failure,
}

final class ReminderState extends Equatable {
  const ReminderState({
    this.status = ReminderStatus.initial,
    this.reminders = const <Reminder>[],
  });

  final ReminderStatus status;
  final List<Reminder> reminders;

  ReminderState copyWith({
    ReminderStatus? status,
    List<Reminder>? reminders,
  }) {
    return ReminderState(
      status: status ?? this.status,
      reminders: reminders ?? this.reminders,
    );
  }

  @override
  List<Object> get props => [status, reminders];
}

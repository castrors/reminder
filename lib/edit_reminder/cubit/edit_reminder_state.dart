part of 'edit_reminder_cubit.dart';

enum EditReminderStatus {
  initial,
  loading,
  success,
  failure,
}

final class EditReminderState extends Equatable {
  const EditReminderState({
    this.status = EditReminderStatus.initial,
  });

  final EditReminderStatus status;

  @override
  List<Object> get props => [];
}

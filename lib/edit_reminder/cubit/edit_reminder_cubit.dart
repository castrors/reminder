import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reminder/reminder/data/model/reminder.dart';
import 'package:reminder/reminder/data/repository/reminder_repository.dart';

part 'edit_reminder_state.dart';

class EditReminderCubit extends Cubit<EditReminderState> {
  EditReminderCubit(this._reminderRepository)
      : super(const EditReminderState());

  final ReminderRepository _reminderRepository;

  void updateReminder(Reminder reminder) {
    emit(const EditReminderState(status: EditReminderStatus.loading));
    _reminderRepository.updateReminder(reminder).then((_) {
      emit(const EditReminderState(status: EditReminderStatus.success));
    }).catchError((_) {
      emit(const EditReminderState(status: EditReminderStatus.failure));
    });
  }

  void addReminder(Reminder reminder) {
    emit(const EditReminderState(status: EditReminderStatus.loading));
    _reminderRepository.addReminder(reminder).then((_) {
      emit(const EditReminderState(status: EditReminderStatus.success));
    }).catchError((_) {
      emit(const EditReminderState(status: EditReminderStatus.failure));
    });
  }

  void deleteReminder(Reminder reminder) {
    emit(const EditReminderState(status: EditReminderStatus.loading));
    _reminderRepository.deleteReminder(reminder).then((_) {
      emit(const EditReminderState(status: EditReminderStatus.success));
    }).catchError((_) {
      emit(const EditReminderState(status: EditReminderStatus.failure));
    });
  }
}

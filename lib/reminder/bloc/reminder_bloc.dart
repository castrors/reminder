import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:reminder/reminder/data/model/reminder.dart';
import 'package:reminder/reminder/data/repository/reminder_repository.dart';

part 'reminder_event.dart';
part 'reminder_state.dart';

class ReminderBloc extends Bloc<ReminderEvent, ReminderState> {
  ReminderBloc(this.reminderRepository) : super(const ReminderState()) {
    on<RemindersRequested>(_onRemindersRequested);
    on<ReminderAdded>(_onReminderAdded);
    on<ReminderUpdated>(_onReminderUpdated);
  }

  ReminderRepository reminderRepository;

  Future<void> _onRemindersRequested(
    RemindersRequested event,
    Emitter<ReminderState> emit,
  ) async {
    emit(state.copyWith(status: ReminderStatus.loading));

    final reminders = await reminderRepository.getReminders();

    emit(
      state.copyWith(
        status: ReminderStatus.loaded,
        reminders: reminders,
      ),
    );
  }

  void _onReminderAdded(
    ReminderAdded event,
    Emitter<ReminderState> emit,
  ) {
    emit(
      state.copyWith(
        reminders: List<Reminder>.from(state.reminders)..add(event.reminder),
      ),
    );
  }

  void _onReminderUpdated(
    ReminderUpdated event,
    Emitter<ReminderState> emit,
  ) {
    emit(
      state.copyWith(
        reminders: state.reminders
            .map(
              (reminder) => reminder.key == event.reminder.key
                  ? event.reminder
                  : reminder,
            )
            .toList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({
    required this.onDateTimeChanged,
    this.initialDateTime,
    super.key,
  });
  final void Function(DateTime) onDateTimeChanged;
  final DateTime? initialDateTime;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? selectedDateTime;

  @override
  void initState() {
    super.initState();
    selectedDateTime = widget.initialDateTime;
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      if (context.mounted) {
        final pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(
            selectedDateTime ?? DateTime.now(),
          ),
        );

        if (pickedTime != null) {
          setState(() {
            selectedDateTime = DateTime(
              pickedDate.year,
              pickedDate.month,
              pickedDate.day,
              pickedTime.hour,
              pickedTime.minute,
            );
            widget.onDateTimeChanged(selectedDateTime!);
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () => _selectDateTime(context),
          child: const Text('Select Date and Time'),
        ),
        if (selectedDateTime != null)
          Text(
            'Selected: ${selectedDateTime!.toLocal()}',
            style: const TextStyle(fontSize: 16),
          ),
      ],
    );
  }
}

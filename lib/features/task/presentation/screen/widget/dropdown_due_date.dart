import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DropdownDueDate extends StatefulWidget {
  const DropdownDueDate({super.key, required this.timeController});

  final TextEditingController timeController;

  @override
  State<DropdownDueDate> createState() => _DropdownDueDateState();
}

class _DropdownDueDateState extends State<DropdownDueDate> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  DateFormat dateFormat = DateFormat('EEEE, dd-MM-yyyy');
  DateFormat timeFormat = DateFormat('hh:mm a');

  DateTime? picked;

  @override
  initState() {
    super.initState();
    if (widget.timeController.text.isNotEmpty) {
      _selectedDate = DateTime.parse(widget.timeController.text);
      _selectedTime = TimeOfDay.fromDateTime(_selectedDate!);
      dateController.text = dateFormat.format(_selectedDate!);
      timeController.text = timeFormat.format(_selectedDate!);
      picked = _selectedDate;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(
        () {
          _selectedDate = picked;
          dateController.text = dateFormat.format(_selectedDate!);
          widget.timeController.text = DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
            _selectedTime?.hour ?? 1,
            _selectedTime?.minute ?? 1,
          ).toString();
        },
      );
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(
        () {
          _selectedTime = picked;
          widget.timeController.text = DateTime(
            _selectedDate!.year,
            _selectedDate!.month,
            _selectedDate!.day,
            _selectedTime!.hour,
            _selectedTime!.minute,
          ).toString();

          timeController.text = timeFormat.format(
            DateTime(
              _selectedDate!.year,
              _selectedDate!.month,
              _selectedDate!.day,
              _selectedTime!.hour,
              _selectedTime!.minute,
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: dateController,
          onTap: () => _selectDate(context),
          decoration: InputDecoration(
            hintText: 'Due date',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        if (_selectedDate != null)
          SizedBox(
            height: 50.h,
          ),
        if (_selectedDate != null)
          TextFormField(
            controller: timeController,
            onTap: () => _selectTime(context),
            decoration: InputDecoration(
              hintText: 'Select Time',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
      ],
    );
  }
}

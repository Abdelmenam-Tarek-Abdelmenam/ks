import 'package:final_projects/presentation/shared/widget/form_field.dart';
import 'package:flutter/material.dart';
import '../../../domain_layer/date_extensions.dart';

class CustomDateTimePicker extends StatefulWidget {
  const CustomDateTimePicker(
      {super.key,
     required this.labelText,
     required this.controller,
      this.onValidate,
      this.onSaved , this.isReverse = true});

  final bool isReverse;
  final TextEditingController controller ;
  final String labelText;
  final String? Function(String?)? onValidate;
  final Function(String?)? onSaved;

  @override
  State<CustomDateTimePicker> createState() => _CustomDateTimePickerState();
}

class _CustomDateTimePickerState extends State<CustomDateTimePicker> {

  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      controller: widget.controller,
      title: widget.labelText,
      keyboardType: TextInputType.none,
      validator: widget.onValidate,
      onTab: () => showPicker(context),
    );
  }

  Future<void> showPicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: widget.isReverse ? DateTime(1990) : DateTime.now(),
      lastDate: widget.isReverse ? DateTime.now() : DateTime(2050)
    );

    if (selectedDate != null && selectedDate != DateTime.now()) {
      widget.controller.text = selectedDate.formatDate;
      setState(() {

      });
      // FocusScope.of(context).unfocus();
      // print(selectedDate.formatDate);
    }
  }
}


class CustomTimePicker extends StatefulWidget {
  const CustomTimePicker({
    super.key,
    required this.labelText,
    required this.controller,
    this.onValidate,
    this.onSaved,
  });

  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? onValidate;
  final Function(String?)? onSaved;

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  @override
  Widget build(BuildContext context) {
    return DefaultFormField(
      controller: widget.controller,
      title: widget.labelText,
      keyboardType: TextInputType.none,
      validator: widget.onValidate,
      onTab: () => showTimePickerDialog(context),
    );
  }

  Future<void> showTimePickerDialog(BuildContext context) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Format the time in HH:MM:SS format (or adjust according to your needs)
      final formattedTime = selectedTime.format(context);  // Format like "HH:mm AM/PM"
      widget.controller.text = formattedTime;
      setState(() {});  // Update the UI
    }
  }
}

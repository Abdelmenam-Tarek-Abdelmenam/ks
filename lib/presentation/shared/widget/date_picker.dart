import 'package:final_projects/presentation/shared/widget/form_field.dart';
import 'package:flutter/material.dart';
import '../../../domain_layer/date_extensions.dart';

class CustomDateTimePicker extends StatefulWidget {
  const CustomDateTimePicker(
      {super.key,
     required this.labelText,
     required this.controller,
      this.onValidate,
      this.onSaved});

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
      onTab: () => showPicker(context),
    );
  }

  Future<void> showPicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: widget.controller.text.parseDate,
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
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

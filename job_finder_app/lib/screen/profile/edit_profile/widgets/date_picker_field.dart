import 'package:flutter/material.dart';

class DatePickerField extends StatelessWidget {
  final String label;
  final String initialValue;
  final ValueChanged<String> onDatePicked;

  const DatePickerField({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.onDatePicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () async {
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.parse(initialValue),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            onDatePicked(pickedDate.toIso8601String().split('T').first);
          }
        },
        child: AbsorbPointer(
          child: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select your $label";
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}

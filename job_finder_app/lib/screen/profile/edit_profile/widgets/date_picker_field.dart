import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Ensure you have intl package in pubspec.yaml

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
    // Handle null initialValue (if needed)
    String displayValue = initialValue.isEmpty ? "Select Date" : initialValue;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () async {
          // Show the date picker when the field is tapped
          DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: initialValue.isNotEmpty
                ? DateTime.parse(initialValue)
                : DateTime.now(), // Use current date if initialValue is empty
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
          );
          if (pickedDate != null) {
            // Format the date as yyyy-MM-dd
            String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
            onDatePicked(
                formattedDate); // Call callback with the formatted date
          }
        },
        child: AbsorbPointer(
          // Use AbsorbPointer to disable editing, only trigger the date picker on tap
          child: TextFormField(
            readOnly: true, // Prevent manual text input
            initialValue: displayValue,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(color: Theme.of(context).primaryColor),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              suffixIcon: Icon(Icons.calendar_today), // Calendar icon
            ),
            validator: (value) {
              if (value == null || value.isEmpty || value == "Select Date") {
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

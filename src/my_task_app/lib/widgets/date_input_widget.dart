import 'package:flutter/material.dart';

class DateInputWidget extends StatefulWidget {
  final TextEditingController controller;
  const DateInputWidget({super.key, required this.controller});

  @override
  State<DateInputWidget> createState() => DateInputWidgetState();
}

class DateInputWidgetState extends State<DateInputWidget> {
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        widget.controller.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: 'Select Date',
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              _selectDate(context);
            },
          ),
        ),
        readOnly: true, 
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePicker extends StatefulWidget {
  final String label;
  final Function(DateTime) onValueChanged;
  final DateTime? initialDate;

  const DatePicker(
      {super.key,
        required this.label,
        required this.onValueChanged,
        this.initialDate});
  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final DateFormat dateFormatter = DateFormat('yMMMEd');
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    if (widget.initialDate != null) {
      controller.text = dateFormatter.format(widget.initialDate!).toString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Colors.grey)),
      child: GestureDetector(
        onTap: () => _selectDate(context, controller, widget.onValueChanged),
        child: AbsorbPointer(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: widget.label,
                suffixIcon: const Icon(Icons.arrow_drop_down),
              ),
              controller: controller,
              keyboardType: TextInputType.datetime,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(
      BuildContext context,
      TextEditingController controller,
      Function(DateTime) onValueChanged) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900, 1),
        lastDate: DateTime(2100));

    setState(() {
      if (picked != null) {
        onValueChanged(picked);
        controller.text = dateFormatter.format(picked).toString();
      }
    });
  }
}

import 'package:baby_age/presentation/utils/date_time_mapper.dart';
import 'package:flutter/material.dart';

class SelectedDateView extends StatelessWidget {
  final DateTime startDate;
  final Function(DateTime) onStartDateChanged;

  SelectedDateView(
      {Key? key, required this.startDate, required this.onStartDateChanged})
      : super(key: key);

  late DateTime selectedDate;

  @override
  void initState() {
    selectedDate = startDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Start Date: ${DateTimeMapper.formatDate(startDate)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          ElevatedButton(
            child: const Text('Change'),
            onPressed: () {
              onChangeButtonPressed(context);
            },
          ),
        ],
      ),
    );
  }

  void onChangeButtonPressed(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
      firstDate: startDate.subtract(const Duration(days: 280)),
      lastDate: startDate.add(const Duration(days: 280)),
    );

    if (picked != null && picked != startDate) {
      onStartDateChanged(picked);
    }
  }
}

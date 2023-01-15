import 'package:baby_age/presentation/utils/date_time_mapper.dart';
import 'package:flutter/material.dart';

class SelectedDateView extends StatelessWidget {
  final DateTime startDate;

  const SelectedDateView({Key? key, required this.startDate}) : super(key: key);

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
              showDatePicker(
                context: context,
                initialDate: startDate,
                firstDate: startDate,
                lastDate: startDate.add(const Duration(days: 280)),
              );
            },
          ),
        ],
      ),
    );
  }
}

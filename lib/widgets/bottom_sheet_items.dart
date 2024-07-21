import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/cubit/tasks_cubit.dart';

class BottomSheetItems extends StatelessWidget {
  BottomSheetItems({super.key});
  final TextEditingController titleController = TextEditingController();

  final TextEditingController timeController = TextEditingController();

  final TextEditingController dateController = TextEditingController();

  final DateTime timeNow = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        defaultTextFormField(
          controller: titleController,
          readOnly: false,
          label: 'New Task',
          prefixIcon: const Icon(Icons.add_task),
          message: 'task name',
          textInputType: TextInputType.text,
          onChanged: (value) {
            TasksCubit.get(context).name = value;
          },
        ),
        const SizedBox(
          height: 16,
        ),
        defaultTextFormField(
          controller: timeController,
          label: 'Time Task',
          prefixIcon: const Icon(Icons.watch_later_outlined),
          message: 'task time',
          onTap: () => showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          ).then((value) {
            if (value != null) {
              timeController.text = value.format(context);
              TasksCubit.get(context).time = value.format(context);
            } else {
              return null;
            }
          }),
        ),
        const SizedBox(
          height: 16,
        ),
        defaultTextFormField(
          controller: dateController,
          label: 'Date Task',
          prefixIcon: const Icon(Icons.date_range_outlined),
          message: 'task date',
          onTap: () => showDatePicker(
            context: context,
            initialDate: timeNow,
            firstDate: timeNow,
            lastDate: timeNow.add(const Duration(days: 365)),
          ).then((value) {
            if (value != null) {
              dateController.text = DateFormat.yMMMd().format(value);
              TasksCubit.get(context).date = DateFormat.yMMMd().format(value);
            } else {
              return null;
            }
          }),
        ),
      ],
    );
  }
}

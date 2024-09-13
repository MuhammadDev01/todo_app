import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/cubit/tasks_cubit.dart';

class BottomSheetItems extends StatefulWidget {
  const BottomSheetItems({super.key});

  @override
  State<BottomSheetItems> createState() => _BottomSheetItemsState();
}

class _BottomSheetItemsState extends State<BottomSheetItems> {
  DateTime timeNow = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        defaultTextFormField(
          controller: TasksCubit.get(context).nameController,
          readOnly: false,
          label: 'New Task',
          prefixIcon: const Icon(Icons.add_task),
          message: 'task name',
          textInputType: TextInputType.text,
          onChanged: (value) {
            TasksCubit.get(context).nameController.text = value;
          },
          borderColor:
              TasksCubit.get(context).isDark ? Colors.white : Colors.black,
        ),
        const SizedBox(
          height: 16,
        ),
        defaultTextFormField(
          controller: TasksCubit.get(context).timeController,
          label: 'Time Task',
          prefixIcon: const Icon(Icons.watch_later_outlined),
          message: 'task time',
          onTap: () async {
            showTimePickerMethod();
          },
          borderColor:
              TasksCubit.get(context).isDark ? Colors.white : Colors.black,
        ),
        const SizedBox(
          height: 16,
        ),
        defaultTextFormField(
          controller: TasksCubit.get(context).dateController,
          label: 'Date Task',
          prefixIcon: const Icon(Icons.date_range_outlined),
          message: 'task date',
          onTap: () {
            showDatePickerMethod();
          },
          borderColor:
              TasksCubit.get(context).isDark ? Colors.white : Colors.black,
        ),
      ],
    );
  }

  void showDatePickerMethod() {
    showDatePicker(
      context: context,
      initialDate: timeNow,
      firstDate: timeNow,
      lastDate: timeNow.add(const Duration(days: 365)),
    ).then(
      (value) {
        if (value != null) {
          if (mounted) {
            TasksCubit.get(context).dateController.text =
                DateFormat.yMMMd().format(value);
          }
        } else {
          return null;
        }
      },
    );
  }

  void showTimePickerMethod() {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    ).then(
      (value) {
        if (value != null) {
          if (mounted) {
            TasksCubit.get(context).timeController.text = value.format(context);
          }
        } else {
          return null;
        }
      },
    );
  }
}

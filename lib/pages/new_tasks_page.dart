import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/cubit/tasks_cubit.dart';
import 'package:todo_app/widgets/tasks_builder.dart';

class NewTasksPage extends StatelessWidget {
  const NewTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TasksCubit, TasksStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return TasksBuilder(tasks: TasksCubit.get(context).newTasks);
      },
    );
  }
}

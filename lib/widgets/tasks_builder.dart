import 'package:flutter/material.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/cubit/tasks_cubit.dart';

class TasksBuilder extends StatelessWidget {
  const TasksBuilder({super.key, required this.tasks});

  final List tasks;
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? const Center(
            child: Text(
              'empty',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
                fontSize: 42,
              ),
            ),
          )
        : ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(20.0),
              child: Dismissible(
                onDismissed: (direction) {
                  TasksCubit.get(context).deleteData(id: tasks[index]['id']);
                },
                key: Key(tasks[index]['id'].toString()),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 48,
                      child: Text(
                        '${tasks[index]['time']}',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${tasks[index]['title']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                        Text(
                          '${tasks[index]['date']}',
                          style:
                              const TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 120,
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          tasks[index]['status'] != 'Done'
                              ? TasksCubit.get(context).updateData(
                                  status: 'Done',
                                  id: tasks[index]['id'],
                                )
                              : TasksCubit.get(context).updateData(
                                  status: 'New', id: tasks[index]['id']);
                        },
                        icon: tasks[index]['status'] == 'Done'
                            ? const Icon(
                                Icons.check_box_outlined,
                                color: Colors.teal,
                              )
                            : const Icon(
                                Icons.check_box,
                                color: Colors.teal,
                              ),
                      ),
                    ),
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          tasks[index]['status'] != 'Arichved'
                              ? TasksCubit.get(context).updateData(
                                  status: 'Arichved',
                                  id: tasks[index]['id'],
                                )
                              : TasksCubit.get(context).updateData(
                                  status: 'New', id: tasks[index]['id']);
                        },
                        icon: tasks[index]['status'] == 'Arichved'
                            ? const Icon(
                                Icons.archive_outlined,
                                color: Colors.black54,
                              )
                            : const Icon(
                                Icons.archive,
                                color: Colors.black54,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            separatorBuilder: (context, index) => myDivier(),
            itemCount: tasks.length,
          );
  }
}

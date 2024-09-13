import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              'Empty',
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                letterSpacing: 1,
                fontSize: 40,
              ),
            ),
          )
        : ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            itemBuilder: (context, index) => Dismissible(
              background: Container(
                  decoration: const BoxDecoration(
                      gradient:
                          LinearGradient(begin: Alignment.center, colors: [
                    Colors.red,
                    Colors.white,
                    Colors.red,
                    Colors.white,
                  ])),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.delete),
                      Icon(Icons.delete),
                    ],
                  )),
              onDismissed: (direction) {
                TasksCubit.get(context).deleteData(id: tasks[index]['id']);
              },
              key: Key(tasks[index]['id'].toString()),
              child: BlocBuilder<TasksCubit, TasksStates>(
                builder: (context, state) {
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 44,
                        backgroundColor: Colors.blue,
                        child: Text(
                          '${tasks[index]['time']}',
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                '${tasks[index]['title'][0].toUpperCase()}${tasks[index]['title'].substring(1)}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style:
                                    Theme.of(context).textTheme.displaySmall),
                            Text(
                              '${tasks[index]['date']}',
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          tasks[index]['status'] != 'Done'
                              ? TasksCubit.get(context).updateData(
                                  status: 'Done',
                                  id: tasks[index]['id'],
                                )
                              : TasksCubit.get(context).updateData(
                                  status: 'New', id: tasks[index]['id']);
                        },
                        child: tasks[index]['status'] == 'Done'
                            ? const Icon(
                                Icons.check_box_outlined,
                                color: Colors.teal,
                              )
                            : const Icon(
                                Icons.check_box,
                                color: Colors.teal,
                              ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          tasks[index]['status'] != 'Arichved'
                              ? TasksCubit.get(context).updateData(
                                  status: 'Arichved',
                                  id: tasks[index]['id'],
                                )
                              : TasksCubit.get(context).updateData(
                                  status: 'New', id: tasks[index]['id']);
                        },
                        child: tasks[index]['status'] == 'Arichved'
                            ? const Icon(
                                Icons.archive_outlined,
                                color: Colors.blueGrey,
                              )
                            : const Icon(
                                Icons.archive,
                                color: Colors.blueGrey,
                              ),
                      ),
                    ],
                  );
                },
              ),
            ),
            separatorBuilder: (context, index) => myDivier(),
            itemCount: tasks.length,
          );
  }
}

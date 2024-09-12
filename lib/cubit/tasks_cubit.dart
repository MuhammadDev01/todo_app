import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/pages/archive_tasks_page.dart';
import 'package:todo_app/pages/done_tasks_page.dart';
import 'package:todo_app/pages/new_tasks_page.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksStates> {
  TasksCubit() : super(TasksInitialState());
  static TasksCubit get(context) => BlocProvider.of(context);
  List newTasks = [];
  List doneTasks = [];
  List archivedTasks = [];
  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  int currentIndex = 0;
  bool isOpenBottom = true;
  Database? database;
  bool isDark = false;

  final List<Widget> pages = const [
    NewTasksPage(),
    DoneTasksPage(),
    ArchiveTasksPage(),
  ];
  final List<String> titles = const [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks'
  ];

  changeIndex(int index) {
    currentIndex = index;
    emit(BottomNavigatorHomeState());
  }

  changeThemeMode() {
    isDark = !isDark;
    emit(ChangeThemeModeState());
  }

  openBottom() {
    isOpenBottom = true;
    emit(BottomSheetOpenState());
  }

  closeBottom() {
    isOpenBottom = false;
    emit(BottomSheetCloseState());
  }

  createDatabase() async {
    openDatabase(
      'tasks.db',
      version: 1,
      onCreate: (db, version) {
        debugPrint('DATABASE IS CREATED ..!');
        db.execute('''
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      time TEXT,
      date TEXT,
      status TEXT
    )
  ''').then(
          (value) {
            debugPrint('TABLES CREATED SUCCESSFULLY ..!');
          },
        );
      },
      onOpen: (db) async {
        await getDataFromDatabase(db);
      },
    ).then((value) {
      database = value;
      emit(CreateDatabaseState());
    });
  }

  insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database?.transaction(
      (txn) async {
        txn.rawInsert(
          'INSERT INTO tasks(title, time, date,status) VALUES("$title", "$time", "$date","New")',
        );
      },
    ).then(
      (value) async {
        emit(InsertDatabaseState());
        debugPrint(
          '$value INSERTED SUCCESSFULLY ..!',
        );
        await getDataFromDatabase(database!);
      },
    ).catchError(
      (error) {
        debugPrint(
          'error in inserted data : ${error.toString()}',
        );
      },
    );
  }

  getDataFromDatabase(Database database) {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];
    database.rawQuery('SELECT * FROM tasks').then((value) {
      for (var element in value) {
        if (element['status'] == 'New') {
          newTasks.add(element);
        } else if (element['status'] == 'Done') {
          doneTasks.add(element);
        } else {
          archivedTasks.add(element);
        }
      }
      emit(GetDatabaseState());
    });
  }

  updateData({
    required String status,
    required int id,
  }) {
    database?.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',
        [status, '$id']).then((value) {
      emit(UpdateDataState());
      getDataFromDatabase(database!);
    });
  }

  deleteData({
    required int id,
  }) {
    database
        ?.rawDelete('DELETE FROM tasks WHERE id = ?', ['$id']).then((value) {
      emit(DeleteDataState());
      getDataFromDatabase(database!);
    });
  }
}

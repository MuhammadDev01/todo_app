part of 'tasks_cubit.dart';

@immutable
sealed class TasksStates {}

final class TasksInitialState extends TasksStates {}

final class BottomNavigatorHomeState extends TasksStates {}

final class BottomSheetOpenState extends TasksStates {}

final class BottomSheetCloseState extends TasksStates {}

final class CreateDatabaseState extends TasksStates {}

final class InsertDatabaseState extends TasksStates {}

final class GetDatabaseState extends TasksStates {}

final class UpdateDataState extends TasksStates {}

final class DeleteDataState extends TasksStates {}
final class ChangeThemeModeState extends TasksStates {}


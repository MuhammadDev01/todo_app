// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskModel {
  String name;
  String time;
  String date;
  final String status = 'New';
  TaskModel({
    required this.name,
    required this.time,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': name,
      'time': time,
      'date': date,
    };
  }
}

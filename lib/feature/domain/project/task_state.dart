import 'package:todoapp_mobile/feature/data/model/task.dart';

abstract class TaskState {}

class InitialTaskState extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Task> tasks;
  final bool done;

  TaskLoaded(this.tasks, this.done);
}
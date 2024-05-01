abstract class TaskEvent {}

class TaskLoad extends TaskEvent {
  final String query;

  TaskLoad(this.query);
}

class TaskLoadMore extends TaskEvent {
  final String query;

  TaskLoadMore(this.query);
}
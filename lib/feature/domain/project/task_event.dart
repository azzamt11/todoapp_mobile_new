abstract class TaskEvent {}

class TaskLoad extends TaskEvent {
  final String projectTitle;
  final String query;

  TaskLoad(this.projectTitle, this.query);
}

class TaskLoadMore extends TaskEvent {
  final String projectTitle;
  final String query;

  TaskLoadMore(this.projectTitle, this.query);
}
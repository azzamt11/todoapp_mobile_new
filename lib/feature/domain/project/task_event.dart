abstract class TaskEvent {}

class TaskLoad extends TaskEvent {
  final int projectId;
  final String query;

  TaskLoad(this.projectId, this.query);
}

class TaskDelete extends TaskEvent {
  final int projectId;
  final int id;
  final String query;

  TaskDelete(this.projectId, this.id, this.query);
}

class TaskLoadMore extends TaskEvent {
  final int projectId;
  final String query;

  TaskLoadMore(this.projectId, this.query);
}
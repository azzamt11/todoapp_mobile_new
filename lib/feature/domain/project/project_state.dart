part of 'project_bloc.dart';

abstract class ProjectState {}

class ProjectLoading extends ProjectState {
  @override
  String toString() {
    return "ProjectLoading";
  }
}

class ProjectLoaded extends ProjectState {
  final List<Project> projects;

  ProjectLoaded(this.projects);

  @override
  String toString() {
    return "ProjectLoaded";
  }
}

class ProjectError extends ProjectState {
  @override
  String toString() {
    return "ProjectError";
  }
}

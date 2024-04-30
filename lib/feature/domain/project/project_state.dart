import 'package:todoapp_mobile/feature/data/model/project.dart';

abstract class ProjectState {}

class InitialProjectState extends ProjectState {}

class ProjectLoading extends ProjectState {}

class ProjectLoaded extends ProjectState {
  final List<Project> projects;
  final bool done;

  ProjectLoaded(this.projects, this.done);
}
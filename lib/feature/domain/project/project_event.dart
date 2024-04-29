part of 'project_bloc.dart';

abstract class ProjectEvent {}

class ProjectInfo extends ProjectEvent {

} 

class ProjectFilter extends ProjectEvent {
  final String query;

  ProjectFilter(this.query);
}

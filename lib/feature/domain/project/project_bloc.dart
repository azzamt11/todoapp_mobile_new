import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:todoapp_mobile/feature/data/repository/project_repository.dart';
import 'package:meta/meta.dart';

part 'project_event.dart';
part 'project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepositoryImpl projectsRepository;

  ProjectBloc({required this.projectsRepository})
      : super(ProjectLoading());

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
  if (event is ProjectInfo) {
    yield* _mapProjectFilterToState("?page=1");
  } else if (event is ProjectFilter) {
    yield* _mapProjectFilterToState(event.query);
  }
}

  Stream<ProjectState> _mapProjectFilterToState(String query) async* {
    yield ProjectLoading();
    try {
      var response = await projectsRepository.getAllProjects(query: query);

      if(response.isSuccessful){
        List<Project>? list = response.body;

        await Future.delayed(const Duration(seconds: 5));
        yield ProjectLoaded(list!);
      } else {
        yield ProjectError();
      }
    } catch (e) {
      print("Exception while fetching project details: " + e.toString());
      yield ProjectError();
    }
  }
}

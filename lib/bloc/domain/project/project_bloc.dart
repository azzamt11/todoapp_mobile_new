import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:code/bloc/data/model/project.dart';
import 'package:code/bloc/data/repository/project_repository.dart';
import 'package:meta/meta.dart';

part '../project/project_event.dart';
part '../project/project_state.dart';

class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepositoryImpl projectsRepository;

  ProjectBloc({required this.projectsRepository})
      : super(ProjectLoading());

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event,) async* {
    yield ProjectLoading();
    try {
      var response = await projectsRepository.getAllProjects();

      if(response.isSuccessful){

        List<Project>? list = response.body;

        await Future.delayed(const Duration(seconds: 5));
        yield ProjectLoaded(
          list!
        );

      }else{
        yield ProjectError();
      }

    } catch (e) {
      print("Exception while fetching project details: " + e.toString());
      yield ProjectError();
    }
  }
}

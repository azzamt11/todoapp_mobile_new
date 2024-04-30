import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:todoapp_mobile/feature/data/repository/project_repository.dart';

import 'package:todoapp_mobile/feature/domain/project/project_event.dart';
import 'package:todoapp_mobile/feature/domain/project/project_state.dart';


class ProjectBloc extends Bloc<ProjectEvent, ProjectState> {
  final ProjectRepositoryImpl projectsRepository;
  List<Project> projects= [];
  int initLoadCount = 10;
  int loadMoreCount = 0;
  int loadedLastIndex = 0;

  ProjectBloc({required this.projectsRepository})
      : super(ProjectLoading());

  @override
  ProjectState get initialState => InitialProjectState();

  @override
  Stream<ProjectState> mapEventToState(ProjectEvent event) async* {
    if (event is ProjectLoad) {
      yield ProjectLoading();
      Response<List<Project>> response =  await projectsRepository.getAllProjects(query: event.query);
      projects= response.body?? [];
      loadMoreCount = initLoadCount;
      yield ProjectLoaded(projects, response.body!.isEmpty);
    }
    if (event is ProjectLoadMore) {
      loadedLastIndex += loadMoreCount;
      Response<List<Project>> response =  await projectsRepository.getAllProjects(query: event.query);
      projects += (response.body?? []);
      yield ProjectLoaded(projects, response.body!.isEmpty);
    }
  }
}
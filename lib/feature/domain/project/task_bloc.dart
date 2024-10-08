import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:todoapp_mobile/feature/data/model/task.dart';
import 'package:todoapp_mobile/feature/data/repository/task_repository_impl.dart';
import 'package:todoapp_mobile/feature/domain/project/task_event.dart';
import 'package:todoapp_mobile/feature/domain/project/task_state.dart';


class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepositoryImpl tasksRepository;
  List<Task> tasks= [];
  int initLoadCount = 10;
  int loadMoreCount = 0;
  int loadedLastIndex = 0;

  TaskBloc({required this.tasksRepository})
      : super(TaskLoading());

  TaskState get initialState => InitialTaskState();

  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    if (event is TaskLoad) {
      yield TaskLoading();
      Response<List<Task>> response =  await tasksRepository.getAllTasks(
        projectId: event.projectId, 
        query: event.query
      );
      tasks= response.body?? [];
      loadMoreCount = initLoadCount;
      yield TaskLoaded(tasks, response.body!.isEmpty);
    }
    if (event is TaskLoadMore) {
      loadedLastIndex += loadMoreCount;
      Response<List<Task>> response =  await tasksRepository.getAllTasks(
        projectId: event.projectId, 
        query: event.query
      );
      tasks += (response.body?? []);
      yield TaskLoaded(tasks, response.body!.isEmpty);
    }
    if (event is TaskDelete) {
      loadedLastIndex += loadMoreCount;
      await tasksRepository.deleteTask(event.projectId, event.id);
      Response<List<Task>> reloadResponse =  await tasksRepository.getAllTasks(
        projectId: event.projectId, 
        query: event.query,
      );
      tasks = (reloadResponse.body?? []);
      yield TaskLoaded(tasks, reloadResponse.body!.isEmpty);
    }
    if (event is TaskCreate) {
      loadedLastIndex += loadMoreCount;
      await tasksRepository.postTask(event.projectId, event.body);
      Response<List<Task>> reloadResponse =  await tasksRepository.getAllTasks(
        projectId: event.projectId,
        query: "",
      );
      tasks = (reloadResponse.body?? []);
      yield TaskLoaded(tasks, reloadResponse.body!.isEmpty);
    }
  }
}


import 'package:chopper/chopper.dart';
import 'package:todoapp_mobile/feature/data/model/task.dart';
import 'package:todoapp_mobile/feature/data/repository/project_repository.dart';
import 'package:todoapp_mobile/feature/data/repository/task_repository.dart';
import 'package:todoapp_mobile/feature/data/service/task_service.dart';


class TaskRepositoryImpl implements TaskRepository{
  final TaskService taskService;

  TaskRepositoryImpl({required this.taskService});



  @override
  Future<Response<List<Task>>> getAllTasks({String? projectTitle, required String query}) async {
    var response = await taskService.getAllTasks(query: query, projectTitle: projectTitle);
    return response.copyWith(body: List<Task>.from(response.body.map((e) => Task.fromJson(e))));
  }

  @override
  Future<Response<Task>> getTask(String projectTitle, String title) async {
    var response = await taskService.getTask(projectTitle, title);
    return  response.copyWith(body: Task.fromJson(response.body));
  }

  Future<Response<Task>> postTask(String projectTitle) async {
    var response = await taskService.postTask(projectTitle);
    return  response.copyWith(body: Task.fromJson(response.body));
  }

}


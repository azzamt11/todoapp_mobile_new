

import 'package:chopper/chopper.dart';
import 'package:todoapp_mobile/feature/data/model/task.dart';
import 'package:todoapp_mobile/feature/data/repository/task_repository.dart';
import 'package:todoapp_mobile/feature/data/service/task_service.dart';


class TaskRepositoryImpl implements TaskRepository{
  final TaskService taskService;

  TaskRepositoryImpl({required this.taskService});



  @override
  Future<Response<List<Task>>> getAllTasks({required int? projectId, required String query}) async {
    var response = await taskService.getAllTasks(query: query, projectId: projectId);
    return response.copyWith(body: List<Task>.from(response.body.map((e) => Task.fromJson(e))));
  }

  @override
  Future<Response<Task>> getTask(int projectId, int id) async {
    var response = await taskService.getTask(projectId, id);
    return  response.copyWith(body: Task.fromJson(response.body));
  }

  Future<Response> postTask(int projectId, Map<String, dynamic> body) async {
    var response = await taskService.postTask(projectId, body);
    return response;
  }

  Future<Response> deleteTask(int projectId, int id) async {
    var response = await taskService.deleteTask(projectId, id);
    return  response;
  }

}


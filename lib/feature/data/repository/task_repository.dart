import 'package:chopper/chopper.dart';

abstract class TaskRepository{
  Future<Response> getAllTasks({required int? projectId, required String query});
  Future<Response> getTask(int projectId, int id);
  Future<Response> deleteTask(int projectId, int id);
  Future<Response> postTask(int projectId, Map<String, dynamic> body);
}
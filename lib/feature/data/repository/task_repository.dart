import 'package:todoapp_mobile/feature/data/model/task.dart';
import 'package:chopper/chopper.dart';

abstract class TaskRepository{
  Future<Response> getAllTasks({required int? projectId, required String query});
  Future<Response> getTask(int projectId, int id);
  Future<Response> deleteTask(int projectId, int id);
}
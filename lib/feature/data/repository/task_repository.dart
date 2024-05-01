import 'package:todoapp_mobile/feature/data/model/task.dart';
import 'package:chopper/chopper.dart';

abstract class TaskRepository{
  Future<Response> getAllTasks({required String? projectTitle, String? query});
  Future<Response> getTask(String projectTitle, String title);
}
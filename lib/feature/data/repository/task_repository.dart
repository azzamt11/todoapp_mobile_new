import 'package:todoapp_mobile/feature/data/model/task.dart';
import 'package:chopper/chopper.dart';

abstract class TaskRepository{
  Future<Response> getAllTasks({String? query});
  Future<Response> getTask(String title);
}
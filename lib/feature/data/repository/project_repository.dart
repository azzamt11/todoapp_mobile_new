import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:chopper/chopper.dart';

abstract class ProjectRepository{
  Future<Response> getAllProjects({required String query});
  Future<Response> getProject(int id);
}
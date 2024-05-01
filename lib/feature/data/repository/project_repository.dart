import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:chopper/chopper.dart';

abstract class ProjectRepository{
  Future<Response> getAllProjects({String? query});
  Future<Response> getProject(String title);
}
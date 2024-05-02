

import 'package:chopper/chopper.dart';
import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:todoapp_mobile/feature/data/repository/project_repository.dart';
import 'package:todoapp_mobile/feature/data/service/project_service.dart';


class ProjectRepositoryImpl implements ProjectRepository{
  final ProjectService projectService;

  ProjectRepositoryImpl({required this.projectService});

  @override
  Future<Response<List<Project>>> getAllProjects({required String query}) async {
    var response = await projectService.getAllProjects(query: query);
    return response.copyWith(body: List<Project>.from(response.body.map((e) => Project.fromJson(e))));
  }

  @override
  Future<Response<Project>> getProject(String title) async {
    var response = await projectService.getProject(title);
    return  response.copyWith(body: Project.fromJson(response.body));
  }

}


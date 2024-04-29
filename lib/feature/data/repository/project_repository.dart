

import 'package:chopper/chopper.dart';
import 'package:code/feature/data/model/project.dart';
import 'package:code/feature/data/repository/project_repository.dart';
import 'package:code/feature/data/repository/repository.dart';
import 'package:code/feature/data/service/project_service.dart';


class ProjectRepositoryImpl implements Repository{
  final ProjectService projectService;

  ProjectRepositoryImpl({required this.projectService});



  @override
  Future<Response<List<Project>>> getAllProjects({String? query}) async {
    var response = await projectService.getAllProjects(query: query);
    return response.copyWith(body: List<Project>.from(response.body.map((e) => Project.fromJson(e))));
  }

  @override
  Future<Response<Project>> getProject(String title) async {
    var response = await projectService.getProject(title);
    return  response.copyWith(body: Project.fromJson(response.body));
  }

}


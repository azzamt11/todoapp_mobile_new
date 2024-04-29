import 'package:code/bloc/data/model/project.dart';
import 'package:chopper/chopper.dart';

abstract class Repository{
  Future<Response> getAllProjects();
  Future<Response> getProject(String title);

}
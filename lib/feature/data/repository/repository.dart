import 'package:code/feature/data/model/project.dart';
import 'package:chopper/chopper.dart';

abstract class Repository{
  Future<Response> getAllProjects({String? query});
  Future<Response> getProject(String title);

}
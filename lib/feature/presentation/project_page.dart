import 'package:todoapp_mobile/feature/data/repository/project_repository.dart';
import 'package:todoapp_mobile/feature/data/repository/project_repository.dart';
import 'package:todoapp_mobile/feature/domain/project/project_bloc.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/string_functions.dart';
import 'package:todoapp_mobile/feature/presentation/widget/project_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
  late final ProjectRepositoryImpl _projectRepository;
  late final ProjectBloc _projectBloc;

  String query= "?page=1";

  List<String> filters= [];

  @override
  void initState() {
    _projectRepository = RepositoryProvider.of<ProjectRepositoryImpl>(context);
    _projectBloc =
        ProjectBloc(projectsRepository: _projectRepository);
    _projectBloc.add(ProjectInfo());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder(
          bloc: _projectBloc,
          builder: projectBuilder,
      ),
    ));
  }

  Widget projectBuilder(BuildContext context, ProjectState state) {
    if (state is ProjectLoading) {
      return const CircularProgressIndicator();
    }
    if (state is ProjectLoaded) {
      return ProjectTab(
        projects: state.projects, 
        blocFunction: blocFunction, 
        filters: filters
      );
    }
    return const Text('Unable to fetch the project!');
  }

  void blocFunction(List<String> filters) {
    _projectBloc.add(ProjectFilter(StringFunctions().getProjectQuery(filters)));
  }
}

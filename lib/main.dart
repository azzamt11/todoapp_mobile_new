import 'package:todoapp_mobile/feature/data/repository/project_repository_impl.dart';
import 'package:todoapp_mobile/feature/data/service/project_service.dart';
import 'package:todoapp_mobile/feature/presentation/initial_page.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

void main() {
  Logger.root.level = Level.ALL; // defaults to Level.INFO
  Logger.root.onRecord.listen((record) {
    print('${record.level.name}: ${record.time}: ${record.message}');
  });

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  static ProjectService projectService = ProjectService.create();
  final ProjectRepositoryImpl projectsRepository = ProjectRepositoryImpl(projectService: projectService);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (_) => projectsRepository,
          )
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black12),
            useMaterial3: true,
          ),
          home: const InitialPage(),
          debugShowCheckedModeBanner: false,
        )
    );
  }
}

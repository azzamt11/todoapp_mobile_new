import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:flutter/material.dart';

class ProjectTab extends StatelessWidget {
  final List<Project> projects;
  const ProjectTab({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(projects.toString())
      )
    );
  }
}
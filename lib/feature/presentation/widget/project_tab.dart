import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:flutter/material.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/string_functions.dart';
import 'package:todoapp_mobile/feature/presentation/widget/filter_drawer.dart';

class ProjectTab extends StatefulWidget {
  final List<Project> projects;
  final ValueChanged<List<String>> blocFunction;
  final List<String> filters;
  const ProjectTab({
    super.key, 
    required this.projects, 
    required this.blocFunction, 
    required this.filters
  });

  @override
  State<ProjectTab> createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> {
  int drawerIncrement= 0;

  bool isChosing= false;

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: SizedBox(
              height: size.height,
              width: size.width,
              child: Column(
                children: [
                  Text("query= ${StringFunctions().getProjectQuery(widget.filters)}"),
                  ElevatedButton(
                    onPressed: () async{
                      debugPrint("drawerIncrement= $drawerIncrement");
                      setState(() {
                        drawerIncrement++;
                        isChosing= true;
                      });
                    }, 
                    child: const Text("Filter")
                  )
                ],
              )
            )
          ),
          FilterDrawer(
            isLoading: false, 
            height: size.height, 
            filters: widget.filters, 
            drawerIncrement: drawerIncrement, 
            stateFunction: stateFunction
          )
        ],
      ),
    );
  }

  Future<void> stateFunction(List<String> filters) async{
    widget.blocFunction(filters);
    Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      drawerIncrement++;
      isChosing= false;
    });
  }

}
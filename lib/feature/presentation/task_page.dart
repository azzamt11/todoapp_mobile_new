import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:todoapp_mobile/feature/data/repository/task_repository_impl.dart';
import 'package:todoapp_mobile/feature/domain/project/task_bloc.dart';
import 'package:todoapp_mobile/feature/domain/project/task_event.dart';
import 'package:todoapp_mobile/feature/domain/project/task_state.dart';
import 'package:todoapp_mobile/feature/presentation/constants/constants.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/string_functions.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/text_styles.dart';

import 'package:todoapp_mobile/feature/presentation/widget/filter_drawer.dart';
import 'package:todoapp_mobile/feature/presentation/widget/input_field.dart';
import 'package:todoapp_mobile/feature/presentation/widget/task_item_card.dart';


class TaskPage extends StatefulWidget {
  final Project project;
  const TaskPage({
    super.key,
    required this.project
  });

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
   late final TaskRepositoryImpl _taskRepository;
   late final TaskBloc _taskBloc;

   List<String> filters= [
    "Created",
    "Ascending",
    "None"
  ];

  bool isChosing= false;
  bool isSearchLoading= false;
  bool localDone= false;
  bool deleteIsLoading= false;

  int currentPage= 1;
  int drawerIncrement= 0;
  
  String searchText= "";

  TextEditingController controller= TextEditingController();
  ScrollController infGridController= ScrollController();
  FocusNode node= FocusNode();

  @override
  void initState() {
    super.initState();

    _taskRepository = RepositoryProvider.of<TaskRepositoryImpl>(context);
    _taskBloc = TaskBloc(tasksRepository: _taskRepository);

    //initial data load
    _taskBloc.add(TaskLoad(
      widget.project.id??0, 
      StringFunctions().getTaskQuery(filters)
    ));

    //triggers when scrolling reached to bottom
    infGridController.addListener(() {
      if (infGridController.position.pixels >= 
        infGridController.position.maxScrollExtent) {
        loadMoreData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Material(
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Container(
              height: size.height,
              width: size.width,
              color: Colors.white,
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                      height: size.height,
                      width: size.width,
                      padding: const EdgeInsets.only(top: 15),
                      child: Stack(
                        children: [
                          SizedBox(
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: isSearchLoading? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 45,
                                    padding: EdgeInsets.symmetric(horizontal: 17),
                                    width: size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 45,
                                          width: size.width- 200,
                                          child: Row(
                                            children: [
                                              Text(
                                                widget.project.title?? "Untitled", 
                                                style: TextStyles().getStyle(4),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ]
                                          )
                                        ),
                                        SizedBox(
                                          height: 45,
                                          width: 100,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: FloatingActionButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      drawerIncrement++;
                                                      isChosing= true;
                                                    });
                                                  },
                                                  backgroundColor: Colors.black,
                                                  child: const Icon(Icons.settings, color: Colors.white, size: 20),
                                                )
                                              ),
                                              SizedBox(width: 5),
                                              SizedBox(
                                                height: 40,
                                                width: 40,
                                                child: FloatingActionButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      drawerIncrement++;
                                                      isChosing= true;
                                                    });
                                                  },
                                                  backgroundColor: Colors.black,
                                                  child: const Icon(Icons.search, color: Colors.white, size: 20),
                                                )
                                              ),

                                            ],
                                          )
                                        )
                                      ],
                                    )
                                  ),
                                  isSearchLoading
                                      ? const CircularProgressIndicator()
                                      : getListView(size)
                                ],
                              )
                          ),
                        ],
                      )
                  )
                )
              )
            )
          ),
          FilterDrawer(
            isLoading: false, 
            height: size.height, 
            filters: filters, 
            drawerIncrement: drawerIncrement, 
            sortByList: Constants().taskSortByList,
            sortByOrder: Constants().taskSortByOrder,
            filterList: Constants().taskfilterList,
            stateFunction: stateFunction
          )
        ],
      ),
    );
  }

  Widget getInputField(var size) {
    return Container(
      height: 40,
      width: size.width- 100,
      padding: const EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 3,
            spreadRadius: 3
          )
        ]
      ),
      child: Align(
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Container(
                  color: Colors.transparent,
                  height: 45,
                  width: 35,
                  child: const Center(
                      child: Icon(
                          Icons.search,
                          color: Colors.black,
                          size: 20
                      )
                  )
              ),
              SizedBox(
                height: 28,
                width: size.width- 157,
                child: InputField(
                  controller: controller,
                  node: node,
                  index: 0,
                  string: "Cari Task",
                  obscure: false,
                  textInputType: TextInputType.text,
                  onSubmitFunction: () {
                    loadData(controller.text);
                    setState(() {
                      searchText= controller.text;
                    });
                  },
                  onTextIsEmptyFunction: () {},
                  onTextIsNotEmptyFunction: () {},
                ),
              ),
            ],
          )
      ),
    );
  }

  Widget getListView(var size) {
    return Container(
        width: size.width,
        height: size.height- 100,
        padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
        child: BlocBuilder(
          bloc: _taskBloc,
          builder: (context, state) {
            if (state is TaskLoaded) {
              return ListView.builder(
                controller: infGridController, 
                itemCount: state.tasks.length+ (!state.done? 1 : 0),
                padding: EdgeInsets.only(bottom: 15),
                itemBuilder: (context, i) {
                  if (i == state.tasks.length) {
                    //showing loader at the bottom of list
                    if(state.tasks.length%10==0 && !state.done) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      return SizedBox(height: 0);
                    }
                  }
                  return TaskItemCard(
                    data: state.tasks[i], 
                    defaultWidth: size.width, 
                    deleteIsLoading: deleteIsLoading, 
                    deleteFunction: deleteFunction, 
                    type: 1
                  );
                }
              );
            }
            return Container(
              height: 100,
              width: size.width,
              child: Center(child: CircularProgressIndicator())
            );
          },
        ),
    );
  }

  Future<void> deleteFunction(int id) async {
    setState(() {
      deleteIsLoading= true;
    });
    _taskBloc.add(TaskDelete(widget.project.id??0, id, StringFunctions().getTaskQuery(filters)));
    if(_taskBloc.state == TaskLoaded) {
      deleteIsLoading= false;
    }
  }

  Future<void> stateFunction(List<String> filters) async{
    _taskBloc.add(TaskLoad(
      widget.project.id??0,
      StringFunctions().getTaskQuery(filters)
    ));
    Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      drawerIncrement++;
      isChosing= false;
    });
  }

  void loadData(String text) async {
    debugPrint("bloc function is executed!");
    _taskBloc.add(TaskLoad(
      widget.project.id??0,
      "${StringFunctions().getTaskQuery(filters)}&search=$text&page=1"
    ));
    setState(() {
      currentPage= 1;
    });
  }

  Future<void> loadMoreData() async {
  // Check if the bloc state is not loading
   print("load more data...");
    _taskBloc.add(TaskLoadMore(
      widget.project.id??0,
      "${StringFunctions().getTaskQuery(filters)}&search=${searchText.length> 3? searchText: ""}&page=${currentPage+1}"
    ));
    if(!localDone) {
      setState(() {
        currentPage++;
      });
    }
}

}
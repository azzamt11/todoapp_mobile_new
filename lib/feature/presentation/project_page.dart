import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp_mobile/feature/data/repository/project_repository_impl.dart';
import 'package:todoapp_mobile/feature/domain/project/project_bloc.dart';
import 'package:todoapp_mobile/feature/domain/project/project_event.dart';
import 'package:todoapp_mobile/feature/domain/project/project_state.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/string_functions.dart';
import 'package:todoapp_mobile/feature/presentation/task_page.dart';

import 'package:todoapp_mobile/feature/presentation/widget/filter_drawer.dart';
import 'package:todoapp_mobile/feature/presentation/widget/input_field.dart';
import 'package:todoapp_mobile/feature/presentation/widget/item_card.dart';


class ProjectPage extends StatefulWidget {
  const ProjectPage({
    super.key,
  });

  @override
  State<ProjectPage> createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> {
   late final ProjectRepositoryImpl _projectRepository;
   late final ProjectBloc _projectBloc;

   List<String> filters= [
    "Created",
    "Ascending",
    "None"
  ];

  bool isChosing= false;
  bool isSearchLoading= false;
  bool localDone= false;

  int currentPage= 1;
  int drawerIncrement= 0;
  
  String searchText= "";

  TextEditingController controller= TextEditingController();
  ScrollController infGridController= ScrollController();
  FocusNode node= FocusNode();

  @override
  void initState() {
    super.initState();

    _projectRepository = RepositoryProvider.of<ProjectRepositoryImpl>(context);
    _projectBloc = ProjectBloc(projectsRepository: _projectRepository);

    //initial data load
    _projectBloc.add(ProjectLoad(StringFunctions().getProjectQuery(filters)));

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
                                    width: size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        getInputField(size),
                                        const SizedBox(width: 20),
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
                                        )
                                      ],
                                    )
                                  ),
                                  isSearchLoading
                                      ? const CircularProgressIndicator()
                                      : getInfiniteGridView(size)
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
                  string: "Cari Project",
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

  Widget getInfiniteGridView(var size) {
    return Container(
        width: size.width,
        height: size.height- 100,
        padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
        child: BlocBuilder(
          bloc: _projectBloc,
          builder: (context, state) {
            if (state is ProjectLoaded) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: (size.width/250).round(), // Number of items in each row
                  mainAxisSpacing: 10.0, // Spacing between rows
                  crossAxisSpacing: 10.0, // Spacing between columns
                  childAspectRatio: 1.0, // Aspect ratio (width / height) of each item
                ),
                controller: infGridController, 
                itemCount: state.projects.length+ (!state.done? 1 : 0),
                padding: EdgeInsets.only(bottom: 15),
                itemBuilder: (context, i) {
                  if (i == state.projects.length) {
                    //showing loader at the bottom of list
                    if(state.projects.length%10==0 && !state.done) {
                      return Center(child: CircularProgressIndicator());
                    } else {
                      setState(() {
                        localDone= true;
                      });
                      return SizedBox(height: 0);
                    }
                  }
                  return ItemCard(
                    data: state.projects[i], 
                    onTapFunction: (size) {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> TaskPage()));
                    }
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

  Future<void> stateFunction(List<String> filters) async{
    _projectBloc.add(ProjectLoad(StringFunctions().getProjectQuery(filters)));
    Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      drawerIncrement++;
      isChosing= false;
    });
  }

  void loadData(String text) async {
    debugPrint("bloc function is executed!");
    _projectBloc.add(ProjectLoad(
      "${StringFunctions().getProjectQuery(filters)}&search=$text&page=1"
    ));
    setState(() {
      currentPage= 1;
    });
  }

  Future<void> loadMoreData() async {
  // Check if the bloc state is not loading
   print("load more data...");
    _projectBloc.add(ProjectLoadMore(
      "${StringFunctions().getProjectQuery(filters)}&search=${searchText.length> 3? searchText: ""}&page=${currentPage+1}"
    ));
    if(!localDone) {
      setState(() {
        currentPage++;
      });
    }
}

}
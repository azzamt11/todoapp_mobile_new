import 'dart:math';

import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:flutter/material.dart';
import 'package:infinite_widgets/infinite_widgets.dart';
import 'package:todoapp_mobile/feature/presentation/task_page.dart';

import 'package:todoapp_mobile/feature/presentation/widget/filter_drawer.dart';
import 'package:todoapp_mobile/feature/presentation/widget/input_field.dart';
import 'package:todoapp_mobile/feature/presentation/widget/item_card.dart';


class ProjectTab extends StatefulWidget {
  final List<Project> projects;
  final ValueChanged<List<String>> blocFunction;
  final List<String> filters;
  final ValueChanged<String> searchFunction;
  const ProjectTab({
    super.key, 
    required this.projects, 
    required this.blocFunction, 
    required this.filters,
    required this.searchFunction
  });

  @override
  State<ProjectTab> createState() => _ProjectTabState();
}

class _ProjectTabState extends State<ProjectTab> {
  int drawerIncrement= 0;

  bool isChosing= false;
  bool isSearchLoading= false;
  bool isLoading= false;

  TextEditingController controller= TextEditingController();
  FocusNode node= FocusNode();
  ScrollController infGridController= ScrollController();

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
              child: SafeArea(
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: Container(
                      height: size.height,
                      width: size.width,
                      padding: const EdgeInsets.only(top: 56),
                      child: Stack(
                        children: [
                          SizedBox(
                              width: size.width,
                              child: Column(
                                mainAxisAlignment: isSearchLoading? MainAxisAlignment.start : MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: 100,
                                    width: size.width,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.center,
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
                                            backgroundColor: Colors.white,
                                            child: const Icon(Icons.settings, color: Colors.brown, size: 20),
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
            filters: widget.filters, 
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
        border: Border.all(width: 1, color: Colors.grey),
        color: Colors.white,
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
                    widget.searchFunction(controller.text);
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
    double cardHeight= 150;
    double cardWidth= 150;
    return Container(
        width: size.width,
        height: size.height- 183,
        padding: const EdgeInsets.only(left: 13, right: 13, top: 10),
        child: InfiniteGridView(
          physics: const BouncingScrollPhysics(),
          loadingWidget: SizedBox(
              height: cardHeight,
              width: cardWidth,
              child: const Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator(
                        color: Colors.black12,
                        backgroundColor: Colors.black12,
                      )
                  )
              )
          ),
          controller: infGridController,
          padding: const EdgeInsets.only(bottom: 15),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: cardWidth /(cardHeight+ 20)
          ),
          itemBuilder: (context, index) {
            return ItemCard(
              data: widget.projects[index],
              coverRatio: 190,
              onTapFunction: (size) {
                setState(() {
                  isLoading= true;
                });
                debugPrint("navigating to item detail page is in progress");
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context)=> const TaskPage()
                    )
                );
              },
            );
          },
          itemCount: widget.projects.length,
          hasNext: false,
          nextData: () async{
            loadNextData();
          },
        )
    );
  }

  Future<void> loadNextData() async{
    //I still dont know how to implement this using bloc
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
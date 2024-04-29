import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:todoapp_mobile/feature/presentation/constants/constants.dart';

class FilterDrawer extends StatefulWidget {
  final bool isLoading;
  final double height;
  final String query;
  final int drawerIncrement;
  final ValueChanged<int> stateFunction;
  const FilterDrawer({
    Key? key,
    required this.isLoading,
    required this.height,
    required this.query,
    required this.drawerIncrement,
    required this.stateFunction
  }) : super(key: key);

  @override
  _FilterDrawerState createState() => _FilterDrawerState();
}

class _FilterDrawerState extends State<FilterDrawer> {
  ScrollController scrollController= ScrollController();

  List<String> filters= [
    "Created",
    "title",
    "1"
  ];

  double containerHeight= 0;
  double defaultDrawerHeight= 0;
  double initialDragValue= 0;

  int localDrawerIncrement= 0;

  bool isReadyToHide= false;
  bool higherDrawer= false;

  @override
  void initState() {
    initializePeriodicInspection();
    setState(() {
      defaultDrawerHeight= (70+ 300).toDouble();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return Material(
      color: Colors.transparent,
      child: Container(
          height: containerHeight,
          width: size.width,
          color: Colors.black38,
          child: containerHeight!=0? SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              controller: scrollController,
              child: Column(
                children: [
                  GestureDetector(
                      onTap: () async{
                        await scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 200),
                            curve: Curves.easeInOut
                        );
                        setState(() {
                          containerHeight= 0;
                        });
                      },
                      child: Container(
                          height: containerHeight,
                          width: size.width,
                          color: Colors.transparent,
                          child: Center(
                              child: widget.isLoading? const SizedBox(
                                  height: 30,
                                  width: 30,
                                  child: CircularProgressIndicator(
                                    color: Colors.black12,
                                    backgroundColor: Colors.transparent,
                                  )
                              ) : null
                          )
                      )
                  ),
                  getDrawerBody(size),
                ],
              )
          ) : null
      )
    );
  }

  Widget getDrawerBody(var size) {
    return Container(
        height: size.height+ 100,
        width: size.width,
        decoration: const BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            dragger(
                Container(
                    height: 20,
                    width: size.width,
                    color: Colors.transparent,
                    child: Center(
                      child: Container(
                        height: 5,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(2.5)
                        ),
                      ),
                    )
                ),
                size
            ),
            Container(
                height: size.height+ 70,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dragger(
                        Container(
                          height: 20,
                          width: size.width,
                          color: Colors.transparent,
                        ),
                        size
                    ),
                    const Text(
                      "Sort By",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: defaultDrawerHeight- 75,
                      width: size.width,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: getFilterList(size, Constants().sortByList, 0),
                        )
                      )
                    )
                  ],
                )
            ),
          ],
        )
    );
  }

   Widget dragger(Widget child, var size) {
      double scrollFixedPosition= - size.height+ defaultDrawerHeight;
      return GestureDetector(
          onVerticalDragStart: (value) {
            setState(() {
              initialDragValue= value.globalPosition.dy;
            });
          },
          onVerticalDragUpdate: (value) async{
            if(value.globalPosition.dy + scrollFixedPosition> -50) {
              scrollController.jumpTo(
                  initialDragValue- value.globalPosition.dy+ defaultDrawerHeight
              );
            }
          },
          onVerticalDragEnd: (value) async{
            if(value.velocity.pixelsPerSecond.dy >300) {
              await scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut
              );
              setState(() {
                containerHeight= 0;
              });
            } else if(value.velocity.pixelsPerSecond.dy <-500) {
              await scrollController.animateTo(
                  size.height- 100,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeInOut
              );
              scrollController.animateTo(
                  defaultDrawerHeight,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut
              );
            } else {
              scrollController.animateTo(
                  defaultDrawerHeight,
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut
              );
            }
          },
          child: child
      );
   }

  List<Widget> getFilterList(var size, List<String> filterArg, int type) {
    List<Widget> widgetList= [];
    for(int i=0; i< filterArg.length; i++) {
      widgetList.add(
        GestureDetector(
          onTap: () {
            setState(() {
               filters[type]= filterArg[i];
            });
            closeDrawer();
          },
          child: Container(
            height: 50,
            width: size.width,
            padding: const EdgeInsets.only(left: 15, right: 15),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 20,
                        width: 20,
                        margin: const EdgeInsets.only(bottom: 5, right: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(width: 1, color: Colors.black12),
                          color: filters[type]== filterArg[i]? Colors.black12 : Colors.white
                        ),
                        child: const Center(
                          child: Icon(Icons.check, color: Colors.white, size: 20)
                        )
                      ),
                      Container(
                        height: 25,
                        margin: const EdgeInsets.only(bottom: 5),
                        child: Text(
                          filterArg[i], 
                          style: const TextStyle(fontSize: 17)
                        )
                      ),
                    ],
                  )
                ),
              ],
            )
          )
        )
      );
    }
    return widgetList;
  }

  Future<void> closing() async{
    await Future.delayed(const Duration(milliseconds: 500));
    setState(() {
      localDrawerIncrement= widget.drawerIncrement;
    });
  }

  Future<void> closeDrawer() async{
    await Future.delayed(const Duration(milliseconds: 500));
    await scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut
    );
    await Future.delayed(const Duration(milliseconds: 100));
    setState(() {
      containerHeight= 0;
    });
  }

  Future<void> initializePeriodicInspection() async{
    while(true) {
      if(widget.drawerIncrement>localDrawerIncrement) {
        setState(() {
          defaultDrawerHeight= (100+ 300).toDouble();
        });
        FocusScope.of(context).requestFocus(FocusNode());
        setState(() {
          containerHeight= widget.height;
          localDrawerIncrement= widget.drawerIncrement;
        });
        while(widget.isLoading || !scrollController.hasClients) {
          await Future.delayed(const Duration(milliseconds: 100));
        }
        scrollController.animateTo(
            defaultDrawerHeight,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut
        );
      }
      await Future.delayed(const Duration(milliseconds: 1000));
    }
  }
}
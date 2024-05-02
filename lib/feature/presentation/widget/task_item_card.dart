import 'package:flutter/material.dart';
import 'package:todoapp_mobile/feature/data/model/task.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/text_styles.dart';


class TaskItemCard extends StatefulWidget {
  final Task data;
  final double defaultWidth;
  final bool deleteIsLoading;
  final ValueChanged<int> deleteFunction;
  final int type;
  const TaskItemCard({
    Key? key,
    required this.data,
    required this.defaultWidth,
    required this.deleteIsLoading,
    required this.deleteFunction,
    required this.type
  }) : super(key: key);

  @override
  _TaskItemCardState createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  @override
  Widget build(BuildContext context) {
    double descriptionWidth= widget.defaultWidth- 90- 30;
    return Container(
        height: 140,
        width: widget.defaultWidth,
        margin: widget.type==0
            ? const EdgeInsets.all(5)
            : const EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Color.fromRGBO(31, 31, 31, 1),
        ),
        child: Stack(
          children: [
            Container(
              height: 140,
              width: 90,
              child: Center(
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.blue,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white12,
                          offset: Offset(2, 2),
                          blurRadius: 2, 
                          spreadRadius: 2,
                        )
                      ]
                    ),
                    child: Center(
                      child: Icon(Icons.task,
                          color: Colors.orange,
                          size: 35),
                    ),
                  ),
              )
            ),
            Positioned(
                left: 88,
                top: widget.type==0? 10 : 0,
                child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: descriptionWidth,
                          padding: const EdgeInsets.only(bottom: 7, left: 15),
                          child: Text(
                            widget.data.title??"", style: TextStyles().getStyle(2),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          height: 22,
                          width: descriptionWidth,
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.data.done??false? "Done" : "In Progress",
                              style: TextStyles().getStyle(widget.data.done??false? 6 : 5)
                            ),
                          )
                        ),
                        Container(
                          height: 22,
                          width: descriptionWidth,
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: widget.type==0? Alignment.topLeft : Alignment.bottomLeft,
                            child: Text(
                              "Deadline: ${widget.data.deadline}",
                              style: TextStyles().getStyle(5)
                            )
                          ),
                        ),
                      ],
                    )
                )
            ),
            Positioned(
              bottom: 10,
              left: 105,
              child: SizedBox(
                child: Row(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                if(!widget.deleteIsLoading) {
                                  widget.deleteFunction(widget.data.id??0);
                                }
                              },
                              splashColor: Colors.white12,
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Center(
                                  child: widget.deleteIsLoading
                                    ? CircularProgressIndicator(color: Colors.white) 
                                    : Icon(Icons.delete_outline,
                                    color: Colors.white,
                                    size: 25
                                  ),
                                ),
                              ),
                            )
                          )
                        ],
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          Container(
                            height: 26,
                            width: 26,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.orange,
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                
                              },
                              splashColor: Colors.white12,
                              child: SizedBox(
                                height: 26,
                                width: 26,
                                child: Center(
                                  child: Icon(Icons.edit,
                                    color: Colors.white,
                                    size: 22
                                  ),
                                ),
                              ),
                            )
                          )
                        ],
                      )
                    )
                  ],
                )
              )
            )
          ],
        )
    );
  }
}

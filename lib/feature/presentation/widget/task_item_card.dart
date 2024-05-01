import 'package:flutter/material.dart';
import 'package:todoapp_mobile/feature/data/model/task.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/text_styles.dart';


class TaskItemCard extends StatefulWidget {
  final Task data;
  final double defaultWidth;
  final bool deleteIsLoading;
  final Function deleteFunction;
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
    var size= MediaQuery.of(context).size;
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
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color.fromRGBO(230, 230, 230, 1),
              ),
              child: const Center(
                  child: SizedBox(
                      height: 70,
                      width: 90 - 20,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Center(
                                child: Icon(Icons.task,
                                    color: Colors.white,
                                    size: 20),
                              ),
                            ),
                            SizedBox(
                                height: 50,
                                width: 175 - 20,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text("Tidak Dapat Memuat Gambar",
                                        style: TextStyle(
                                            color: Colors.black12
                                        ),
                                        textAlign: TextAlign.center
                                    )
                                )
                            )
                          ]
                      )
                  )
              )
            ),
            Positioned(
                left: 88,
                top: widget.type==0? 10 : 0,
                child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: descriptionWidth,
                          padding: const EdgeInsets.only(bottom: 7, left: 15),
                          child: Text(
                            widget.data.title??"", style: TextStyles().getStyle(2),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        widget.type==0? Container(
                          height: 25,
                          width: descriptionWidth,
                          padding: const EdgeInsets.only(left: 15),
                          child: Text(
                            widget.data.createdAt.toString(),
                            style: TextStyles().getStyle(3)
                          ),
                        ): Container(
                          height: 45,
                          width: descriptionWidth,
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              widget.data.done!.toLowerCase()=="true"? "Done" : "In Progress",
                              style: TextStyles().getStyle(3)
                            ),
                          )
                        ),
                        Container(
                          height: 25,
                          width: descriptionWidth,
                          padding: const EdgeInsets.only(left: 15),
                          child: Align(
                            alignment: widget.type==0? Alignment.topLeft : Alignment.bottomLeft,
                            child: Text(
                              "Deadline: ${widget.data.deadline}",
                              style: TextStyles().getStyle(3)
                            )
                          ),
                        ),
                      ],
                    )
                )
            ),
            widget.type==0? Positioned(
                bottom: 5,
                left: 89,
                child: Container(
                    margin: const EdgeInsets.only(left: 6),
                    child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            if(!widget.deleteIsLoading) {
                              widget.deleteFunction(widget.data.id??0, size);
                            }
                          },
                          splashColor: Colors.black12,
                          child: SizedBox(
                            height: 30,
                            width: 30,
                            child: Center(
                              child: Icon(Icons.delete_outline,
                                  color: Colors.white,
                                  size: 25
                              ),
                            ),
                          ),
                        )
                    )
                )
            ) : const SizedBox()
          ],
        )
    );
  }
}

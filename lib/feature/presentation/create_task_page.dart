import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoapp_mobile/feature/data/model/project.dart';
import 'package:todoapp_mobile/feature/data/repository/task_repository_impl.dart';
import 'package:todoapp_mobile/feature/domain/project/task_bloc.dart';
import 'package:todoapp_mobile/feature/domain/project/task_event.dart';
import 'package:todoapp_mobile/feature/presentation/constants/constants.dart';
import 'package:todoapp_mobile/feature/presentation/constants/priority.dart';
import 'package:todoapp_mobile/feature/presentation/helpers/text_styles.dart';
import 'package:todoapp_mobile/feature/presentation/widget/input_field.dart';


class CreateTaskPage extends StatefulWidget {
  final Project data;
  const CreateTaskPage({super.key, required this.data});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  late final TaskRepositoryImpl _taskRepository;
  late final TaskBloc _taskBloc;

  ScrollController controller = ScrollController();

  TextEditingController titleController= TextEditingController();
  TextEditingController deadlineController= TextEditingController();
  TextEditingController priorityController= TextEditingController();

  FocusNode titleNode= FocusNode();

  List<TextEditingController> controllerList= [];

  bool updateIsLoading= false;
  bool deleteIsLoading= false;
  bool dataIsLoading= false;
  bool isChoosingPriority= false;

  double bottomMargin= 0;

  Priority priority= Priority();

  DateTime deadline= DateTime.now();

  @override
  void initState() {
    _taskRepository = RepositoryProvider.of<TaskRepositoryImpl>(context);
    _taskBloc = TaskBloc(tasksRepository: _taskRepository);

    setState(() {
      controllerList= [
        titleController,
        priorityController,
        deadlineController,
      ];
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size= MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SizedBox(
            height: size.height,
            width: size.width,
            child: Stack(
              children: [
                getBody(size),
                choosePriority(size), //step A2
              ],
            )
          ),
        )
    );
  }

  Widget getBody(var size) {
    return SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          controller: controller,
          child: SizedBox(
            width: size.width,
            height: 400,
            child: Stack(
                children: [
                  SizedBox(
                      width: size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(top: 40, right: size.width- 50- 18),
                              child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).pop();
                                    },
                                    splashColor: Colors.black12,
                                    highlightColor: Colors.transparent,
                                    focusColor: Colors.transparent,
                                    child: Container(
                                        height: 40,
                                        width: 50,
                                        padding: const EdgeInsets.only(left: 6),
                                        child: const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Icon(Icons.arrow_back, color: Colors.white, size: 25)
                                        )
                                    ),
                                  )
                              )
                          ),
                          Container(
                              height: 50,
                              width: size.width- 40,
                              margin: const EdgeInsets.only(bottom: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Detail Task",
                                  style: TextStyles().getStyle(4),
                                ),

                              )
                          ),
                        ] + inputColumn(size),
                      )
                  ),
                ]
            )
          )
        )
    );
  }

  List<Widget> inputColumn(var size) {
    List<Widget> inputColumn= [
      getInputField(size),
      getDatePicker(size),
      getDropdown(size),
      Container(
        height: 50,
        width: 200,
        margin: EdgeInsets.only(top: 30),
        child: FloatingActionButton(
          onPressed: () {submitFunction();},
          backgroundColor: Colors.black,
          child: SizedBox(
            height: 30,
            width: 300,
            child: Center(
              child: Text("Submit", style: TextStyles().getStyle(2))
            )
          )
        )
      )
    ];
    return inputColumn;
  }

  Widget getInputField(var size) {
    return Container(
      height: 40,
      width: size.width- 40,
      margin: EdgeInsets.only(bottom: 20),
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
                          Icons.task_alt_outlined,
                          color: Colors.black12,
                          size: 20
                      )
                  )
              ),
              SizedBox(
                height: 28,
                width: size.width- 157,
                child: InputField(
                  controller: titleController,
                  node: titleNode,
                  string: "Task Title",
                  obscure: false,
                  textInputType: TextInputType.text,
                  onSubmitFunction: () {
                    
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

  Widget choosePriority(var size) {
    return isChoosingPriority? GestureDetector( //step A3
      onTap: () {
        setState(() {
          isChoosingPriority= false;
        });
      },
      child: Container(
          height: size.height,
          width: size.width,
          color: Colors.black12,
          child: Center(
              child: Container(
                  height: min(size.width+ 100+ 45, size.height- 36),
                  width: min(size.width- 60, size.height-36),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      getPriorityListWidget(size)
                    ],
                  )
              )
          )
      )
    ) : const SizedBox(height: 0);
  }

  Widget getPriorityListWidget(var size) {
    return SizedBox(
      height: min(size.width+ 80- 23, size.height- 56- 23),
      width: size.width- 100,
      child: SingleChildScrollView(
        child: Column(
          children: getPriorityList(size),
        )
      )
    );
  }

  List<Widget> getPriorityList(var size) {
    List<Widget> list= [];
    for(int i=0; i< Constants().priorityList.length; i++) {
      Priority item= Constants().priorityList[i];
      list.add(
        SizedBox(
          height: 40,
          width: size.width- 100,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              splashColor: Colors.black12,
              focusColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () async{
                setState(() {
                  priority= item;
                  isChoosingPriority= false;
                });
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: SizedBox(
                    height: 40,
                    width: size.width- 100,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                            item.title,
                            style: TextStyles().getStyle(2)
                        )
                    )
                )
              )
            )
          )
        )
      );
    }
    return list;
  }

  Widget getDatePicker(var size) {
    return GestureDetector(
      onTap: () {
        pickDate();
      },
      child: Container(
        height: 40,
        width: size.width- 40,
        margin: EdgeInsets.only(bottom: 20),
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
                            Icons.calendar_today,
                            color: Colors.black12,
                            size: 20
                        )
                    )
                ),
                SizedBox(
                  height: 28,
                  width: size.width- 157,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      deadline.toString(),
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          decorationThickness: 1.2,
                        ),
                      ),
                    )
                  )
                ),
              ],
            )
        ),
      )
    );
  }

  Widget getDropdown(var size) {
    return GestureDetector(
      onTap: () {
       setState(() {
         isChoosingPriority= true;
       });
      },
      child: Container(
        height: 40,
        width: size.width- 40,
        margin: EdgeInsets.only(bottom: 20),
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
                            Icons.priority_high,
                            color: Colors.black12,
                            size: 20
                        )
                    )
                ),
                SizedBox(
                  height: 28,
                  width: size.width- 157,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      priority.title,
                      style: GoogleFonts.dosis(
                        textStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          decorationThickness: 1.2,
                        ),
                      ),
                    )
                  )
                ),
              ],
            )
        ),
      )
    );
  }

  Future<void> pickDate() async{
    DateTime? pickedDate= await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color.fromRGBO(31, 31, 31, 1), // <-- SEE HERE
              onPrimary: Colors.white, // <-- SEE HERE
              onSurface: Colors.orange, // <-- SEE HERE
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                backgroundColor: Color.fromRGBO(31, 31, 31, 1),
                foregroundColor: Colors.white,
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    setState(() {
      deadline= pickedDate?? DateTime.now();
    });
  }

  Future<void> submitFunction() async{
    _taskBloc.add(TaskCreate(
      widget.data.id??0,
      {
        "title": titleController.text,
        "deadline": deadline,
        "priority": priority.level
      }
    ));
    Navigator.pop(context);
  }

}

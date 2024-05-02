import 'package:todoapp_mobile/feature/presentation/constants/priority.dart';

class Constants {

  List<String> projectSortByList= [
    "Title",
    "Created",
    "Updated",
  ];

  List<String> projectSortByOrder= [
    "Ascending",
    "Descending"
  ];

  List<String> taskSortByList= [
    "Title",
    "Created",
    "Updated",
    "deadline",
    "priority"
  ];

  List<String> taskSortByOrder= [
    "Ascending",
    "Descending"
  ];

  List<String> projectFilterList= [
    "None"
  ];

  List<String> taskfilterList= [
    "None"
  ];

  List<Priority> priorityList= [
    Priority(level: 1, title: "Low"),
    Priority(level: 2, title: "Medium"),
    Priority(level: 3, title: "Important"),
    Priority(level: 4, title: "Crusial"),
    Priority(level: 5, title: "Emergency")
  ];
}
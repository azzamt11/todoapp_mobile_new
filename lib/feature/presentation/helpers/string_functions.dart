import 'package:flutter/material.dart';

class StringFunctions {

  String getProjectQuery(List<String> filters) {
    debugPrint("filters= ${filters}");
    if(filters.length> 1) {
      return "?page=1&page_size=10&sort_by=${filters[0].toLowerCase()}&sort_order=${filters[1].substring(0, 3).toLowerCase()}";
    } else {
      return "?page=1&page_size=10&sort_by=${filters[0].toLowerCase()}&sort_order=asc";
    }
  }
}
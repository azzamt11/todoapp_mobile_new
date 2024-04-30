import 'package:flutter/material.dart';

class StringFunctions {

  String getProjectQuery(List<String> filters) {
    debugPrint("filters= ${filters}");
    if(filters.length> 1) {
      return "?sort_by=${filters[0].toLowerCase()}&sort_order=${getOrderCode(filters[1])}";
    } else {
      return "?sort_by=${filters[0].toLowerCase()}&sort_order=asc";
    }
  }

  String getOrderCode(String orderTitle) {
    switch(orderTitle) {
      case "Ascending": return "asc";
      case "Descending": return "desc";
      default: return "asc";
    }
  }
}
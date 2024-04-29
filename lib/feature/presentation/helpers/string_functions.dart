class StringFunctions {

  String getProjectQuery(List<String> filters) {
    return "?page=1&page_size=10&sort_by=${filters[0].toLowerCase()}&sort_order=${filters[1].substring(0, 3)}";
  }
}
class FilterModel {
  String field;
  dynamic value;
  FilterType? type = FilterType.FILTER;
  String? filterType = 'contains';
  // bool filter = true;

  FilterModel(
      {required this.field,
      required this.value,
      this.type = FilterType.FILTER,
      this.filterType = 'contains'});
}

enum FilterType {
  FILTER,
  SORT,
  WHERE,
}

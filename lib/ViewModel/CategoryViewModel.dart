import 'package:pinoy_recipes/Enums/Enums.dart';

class CategoryViewModel {
  CategoryEnum category;
  String label;
  bool isSelected;

  CategoryViewModel({this.category, this.label, this.isSelected = false});
}

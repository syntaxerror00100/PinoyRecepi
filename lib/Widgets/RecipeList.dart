import 'package:flutter/material.dart';
import 'package:pinoy_recipes/Models/RecepiModel.dart';
import 'package:pinoy_recipes/Screens/RecipeList/RecipeListItem.dart';

class RecipeList extends StatelessWidget {
  final List<RecepiModel> recipes;

  const RecipeList({this.recipes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: recipes.length,
      itemBuilder: (ctx, index) {
        final recipe = recipes[index];
        return RecepiListItem(
          recepi: recipe,
        );
      },
    );
  }
}

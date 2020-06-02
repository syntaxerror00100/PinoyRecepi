import 'package:flutter/material.dart';
import '../../DataAccess/DatabaseRepository.dart';
import '../../Widgets/RecipeList.dart';
import '../../Models/RecepiModel.dart';

class Favorties extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: DatabaseRepository.recipeRepository.getAllFavoriteRecipe(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return getRecipeListUI(snapshot.data);
          }

          return SizedBox();
        });
  }

  Widget getRecipeListUI(List<RecepiModel> recipes) {
    return RecipeList(
      recipes: recipes,
    );
  }
}

import 'package:flutter/material.dart';
import '../../DataAccess/DatabaseRepository.dart';
import '../../Models/RecipeIngredientModel.dart';

class Ingredients extends StatelessWidget {
  final int recepiId;

  Ingredients({@required this.recepiId});
  List<RecipeIngredientModel> _ingredients = [];

  @override
  Widget build(BuildContext context) {
    debugPrint('build ingredients');

    return FutureBuilder(
      future: _getIngredientsAsync(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return _renderIngredients(context, snapshot.data);
        else
          return SizedBox(
            height: 10,
          );
      },
    );
  }

  Future<List<RecipeIngredientModel>> _getIngredientsAsync() async {
    if (_ingredients.length > 0) return _ingredients;

    _ingredients = await DatabaseRepository.recipeIngredientsRepository
        .getByRecipeId(recepiId);

    debugPrint('Ingredients is ${_ingredients.length}');

    return _ingredients;
  }

  Widget _renderIngredients(
    BuildContext ctx,
    List<RecipeIngredientModel> ingredients,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: ListView(
        children: <Widget>[
          ...ingredients
              .map(
                (e) => _renderIngredientListItem(ctx, e),
              )
              .toList()
        ],
      ),
    );
  }

  Widget _renderIngredientListItem(
    BuildContext ctx,
    RecipeIngredientModel ingredient,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(ctx).accentColor,
        radius: 13,
        child: Icon(
          Icons.add,
          color: Theme.of(ctx).backgroundColor,
        ),
      ),
      title: Text(
        ingredient.ingredient,
        textAlign: TextAlign.left,
        style: Theme.of(ctx).textTheme.headline6,
      ),
      subtitle: Divider(
        color: Colors.grey,
      ),
    );
  }
}

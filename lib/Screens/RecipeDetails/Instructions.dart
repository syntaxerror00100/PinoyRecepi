import 'package:flutter/material.dart';
import 'package:pinoy_recipes/AppTheme.dart';
import '../../DataAccess/DatabaseRepository.dart';
import '../../Models/RecipeInstructionModel.dart';

class Instructions extends StatelessWidget {
  final int recepiId;

  Instructions({this.recepiId});
  List<RecipeInstructionModel> _instructions = [];

  @override
  Widget build(BuildContext context) {
    debugPrint('build ingredients');

    return FutureBuilder(
      future: _getIngredientsAsync(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done)
          return _renderInstructions(context, snapshot.data);
        else
          return SizedBox(
            height: 10,
          );
      },
    );
  }

  Future<List<RecipeInstructionModel>> _getIngredientsAsync() async {
    if (_instructions.length > 0) return _instructions;

    _instructions = await DatabaseRepository.recipeInstructionsRepository
        .getByRecipeId(recepiId);

    return _instructions;
  }

  Widget _renderInstructions(
    BuildContext ctx,
    List<RecipeInstructionModel> instructions,
  ) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 5,
      ),
      child: ListView(
        children: <Widget>[
          ...instructions
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
    RecipeInstructionModel insctruction,
  ) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(ctx).accentColor,
        radius: 13,
        child: Text(
          '${insctruction.orderNumber + 1}',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      title: Text(
        insctruction.details,
        style: Theme.of(ctx)
            .textTheme
            .headline6
            .copyWith(color: AppTheme.textColor),
      ),
      subtitle: Divider(
        color: Colors.grey,
      ),
    );
  }
}

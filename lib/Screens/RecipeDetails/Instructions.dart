import 'package:flutter/material.dart';
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
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Theme.of(ctx).accentColor,
            radius: 13,
            child: Text(
              '${insctruction.orderNumber + 1}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(insctruction.details,
                style: Theme.of(ctx).textTheme.bodyText1),
          ),
        ],
      ),
    );
  }
}

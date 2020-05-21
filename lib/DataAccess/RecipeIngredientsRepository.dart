import '../Models/RecipeIngredientModel.dart';
import './database.dart';

class RecipeIngredientsRepository {
  Future<List<RecipeIngredientModel>> getByRecipeId(int recipeId) async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query(
      "RecipeIngredients",
      where: 'RecepiId=?',
      whereArgs: [recipeId],
    );
    if (result == null) return null;

    return result.map((x) => RecipeIngredientModel.fromMap(x)).toList();
  }
}

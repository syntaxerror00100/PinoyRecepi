import '../Models/RecipeNutritionModel.dart';
import './database.dart';

class RecipeNutritionsRepository {
  Future<List<RecipeNutritionModel>> getByRecipeId(int recipeId) async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query(
      "RecipeNutritions",
      where: 'RecepiId=?',
      whereArgs: [recipeId],
    );
    if (result == null) return null;

    return result.map((x) => RecipeNutritionModel.fromMap(x)).toList();
  }
}

import '../Models/RecipeInstructionModel.dart';
import './database.dart';

class RecipeInstructionsRepository {
  Future<List<RecipeInstructionModel>> getByRecipeId(int recipeId) async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query(
      "RecipeInstructions",
      where: 'RecepiId=?',
      whereArgs: [recipeId],
    );
    if (result == null) return null;

    return result.map((x) => RecipeInstructionModel.fromMap(x)).toList();
  }
}

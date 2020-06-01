import '../Models/RecipeTagsModel.dart';
import './database.dart';

class RecipeTagRepository {
  Future<List<RecipeTagsModel>> getAll() async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query("RecipeTags");
    if (result == null) return null;

    return result.map((x) => RecipeTagsModel.fromMap(x)).toList();
  }

  Future<List<RecipeTagsModel>> getByRecipeId(int recipeId) async {
    final db = await DatabaseBase.instance.database;

    var result = await db
        .query("RecipeTags", where: 'RecepiId=?', whereArgs: [recipeId]);
    if (result == null) return null;

    return result.map((x) => RecipeTagsModel.fromMap(x)).toList();
  }

  Future<RecipeTagsModel> getCookTimeByRecipeId(int recipeId) async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query("RecipeTags",
        where:
            "RecepiId=? AND (Label LIKE '%Cook Time%' OR Label like 'Prep Time')",
        whereArgs: [recipeId]);

    if (result == null || result.length == 0) return null;

    return RecipeTagsModel.fromMap(result.first);
  }
}

import '../Models/RecipeMainIngredients.dart';
import './database.dart';

class RecipeMainIngredientsRepository {
  Future<List<RecipeMainIngredientsModel>> getAll() async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query("RecipeMainIngredients");
    if (result == null) return null;

    return result.map((x) => RecipeMainIngredientsModel.fromMap(x)).toList();
  }

  Future<RecipeMainIngredientsModel> getByName(String name) async {
    final db = await DatabaseBase.instance.database;

    var result = await db
        .query("RecipeMainIngredients", where: 'Name=?', whereArgs: [name]);
    if (result == null) return null;

    return RecipeMainIngredientsModel.fromMap(result.first);
  }
}

import '../Models/RecipeMainIngredients.dart';
import './database.dart';

class RecipeMainIngredientsRepository {
  Future<List<RecipeMainIngredientsModel>> getAll() async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query("RecepiMainIngredients");
    if (result == null) return null;

    return result.map((x) => RecipeMainIngredientsModel.fromMap(x)).toList();
  }
}

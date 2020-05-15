import '../Models/RecepiMainIngredients.dart';
import './database.dart';

class RecepiMainIngredientsRepository {
  Future<List<RecepiMainIngredientsModel>> getAll() async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query("RecepiMainIngredients");
    if (result == null) return null;

    return result.map((x) => RecepiMainIngredientsModel.fromMap(x)).toList();
  }
}

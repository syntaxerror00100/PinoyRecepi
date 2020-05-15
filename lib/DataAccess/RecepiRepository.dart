import 'package:pinoy_recipes/DataAccess/database.dart';
import '../Models/RecepiModel.dart';

class RecepiRepository {
  Future<List<RecepiModel>> getRecepiesByMainIngredientId(
      int ingredientId) async {
    final db = await DatabaseBase.instance.database;

    var result = await db.rawQuery(
        'SELECT * FROM Recipe WHERE MainIngredidentId=?', [ingredientId]);

    if (result == null) return null;

    return result.map((x) => RecepiModel.fromMap(x)).toList();
  }
}

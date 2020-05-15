import '../Models/RecipeTypeModel.dart';
import './database.dart';

class RecipeTypeRepository {
  Future<List<RecipeTypeModel>> getAll() async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query("RecipeTypes");
    if (result == null) return null;

    return result.map((x) => RecipeTypeModel.fromMap(x)).toList();
  }
}

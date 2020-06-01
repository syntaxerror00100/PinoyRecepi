import '../Models/FavoriteModel.dart';
import './database.dart';

class FavoriteRepository {
  final _tableName = 'Favorites';

  Future<List<FavoriteModel>> getAll() async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query(_tableName);
    if (result == null) return null;

    return result.map((x) => FavoriteModel.fromMap(x)).toList();
  }

  Future<bool> isRecipeFavorite(int recipeId) async {
    final db = await DatabaseBase.instance.database;

    var result =
        await db.query(_tableName, where: "RecepiId=?", whereArgs: [recipeId]);

    return result != null && result.length > 0;
  }

  void setAsFavorite(bool isFavorite, int recipeId) async {
    final db = await DatabaseBase.instance.database;

    if (isFavorite)
      db.rawInsert('INSERT INTO $_tableName(RecepiId) VALUES(?)', [recipeId]);
    else
      db.rawDelete('DELETE FROM $_tableName WHERE RecepiId=?', [recipeId]);
  }
}

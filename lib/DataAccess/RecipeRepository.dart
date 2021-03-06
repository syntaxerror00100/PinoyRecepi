import 'package:pinoy_recipes/DataAccess/database.dart';
import 'package:pinoy_recipes/Enums/Enums.dart';
import '../Models/RecepiModel.dart';
import './DatabaseRepository.dart';

class RecipeRepository {
  static const String _tableName = 'Recipe';

  Future<List<RecepiModel>> getRecepiesByMainIngredientId(
      int ingredientId) async {
    final db = await DatabaseBase.instance.database;

    var result = await db.rawQuery(
        'SELECT * FROM Recipe WHERE MainIngredidentId=?', [ingredientId]);

    if (result == null) return null;

    return result.map((x) => RecepiModel.fromMap(x)).toList();
  }

  Future<List<RecepiModel>> getAllFavoriteRecipe() async {
    final db = await DatabaseBase.instance.database;

    var result = await db.rawQuery(
        'SELECT A.* FROM Recipe A INNER JOIN Favorites B ON B.RecepiId = A.Id');

    if (result == null) return null;

    return result.map((x) => RecepiModel.fromMap(x)).toList();
  }

  Future<List<RecepiModel>> searchRecipeBytitle(searchQuery) async {
    final db = await DatabaseBase.instance.database;
    // var result = await db
    //     .query(_tableName, where: "Title LIKE %?%", whereArgs: [searchQuery]);

    // var result = await db
    //     .rawQuery("SELECT * FROM Recipe WHERE Title LIKE '%$searchQuery%'");

    var result = await db.query(
      _tableName,
      where: "Title LIKE ?",
      whereArgs: ['%$searchQuery%'],
    );

    return result.map((x) => RecepiModel.fromMap(x)).toList();
  }

  Future<List<RecepiModel>> getRecepiesByCategory(
      CategoryEnum category, String categoryName) async {
    final db = await DatabaseBase.instance.database;

    switch (category) {
      case CategoryEnum.ByMainIngredients:
        final mainIngredient = await DatabaseRepository
            .recipeMainIngredientsRepository
            .getByName(categoryName);
        var queryResult = await db.query(_tableName,
            where: 'MainIngredidentId=?', whereArgs: [mainIngredient.id]);
        return queryResult.map((x) => RecepiModel.fromMap(x)).toList();
        break;

      case CategoryEnum.ByType:
        final type = await DatabaseRepository.recipeTypeRepository
            .getByName(categoryName);
        var queryResult =
            await db.query(_tableName, where: 'TypeId=?', whereArgs: [type.id]);
        return queryResult.map((x) => RecepiModel.fromMap(x)).toList();

      case CategoryEnum.ByCourse:
        final course = await DatabaseRepository.recipeCourseRepository
            .getByName(categoryName);
        var queryResult = await db
            .query(_tableName, where: 'CourseId=?', whereArgs: [course.id]);
        return queryResult.map((x) => RecepiModel.fromMap(x)).toList();

        break;
      default:
        return null;
    }
  }
}

import '../Models/RecipeCourseModel.dart';
import './database.dart';

class RecipeCourseRepository {
  Future<List<RecipeCourseModel>> getAll() async {
    final db = await DatabaseBase.instance.database;

    var result = await db.query("RecipeCourses");
    if (result == null) return null;

    return result.map((x) => RecipeCourseModel.fromMap(x)).toList();
  }
}

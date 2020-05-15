class RecipeCourseModel {
  int recepiId;
  String name;

  RecipeCourseModel.fromMap(Map<String, dynamic> map) {
    recepiId = map['RecepiId'];
    name = map['Name'];
  }
}

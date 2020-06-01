class FavoriteModel {
  int id;
  int recepiId;

  FavoriteModel({this.id, this.recepiId});

  FavoriteModel.fromMap(Map<String, dynamic> map) {
    id = map['Id'];
    recepiId = map['RecepiId'];
  }
}

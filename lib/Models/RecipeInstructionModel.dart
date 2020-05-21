class RecipeInstructionModel {
  int id;
  int recepiId;
  int orderNumber;
  String details;

  RecipeInstructionModel(
      {this.id, this.recepiId, this.orderNumber, this.details});

  RecipeInstructionModel.fromMap(Map<String, dynamic> map) {
    id = map['Id'];
    recepiId = map['RecepiId'];
    orderNumber = map['OrderNumber'];
    details = map['Details'];
  }
}

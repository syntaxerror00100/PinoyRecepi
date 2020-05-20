class RecepiModel {
  int id;
  int sourceId;
  String title;
  String summary;
  String url;
  String thumbNailUrl;
  String youtubeUrl;
  int typeId;
  int mainIngredidentId;
  int courseId;

  RecepiModel(
      {this.id,
      this.sourceId,
      this.title,
      this.summary,
      this.url,
      this.thumbNailUrl,
      this.youtubeUrl,
      this.typeId,
      this.mainIngredidentId,
      this.courseId});

  RecepiModel.fromMap(Map<String, dynamic> map) {
    id = map['Id'];
    title = map['Title'];
    summary = map['Summary'];
    url = map['url'];
    thumbNailUrl = map['ThumbNailUrl'];
    youtubeUrl = map['YoutubeUrl'];
    typeId = map['TypeId'];
    mainIngredidentId = map['MainIngredidentId'];
    courseId = map['CourseId'];
  }
}

class NoteModel {
  String title;
  String description;
  String id;

  NoteModel({required this.title, required this.description, required this.id});

  factory NoteModel.fromJson(Map<String, dynamic> json) {
    return NoteModel(
      title: json['title'],
      description: json['description'],
      id: json['id'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["title"] = title;
    data["description"] = description;
    data["id"] = id;
    return data;
  }
}

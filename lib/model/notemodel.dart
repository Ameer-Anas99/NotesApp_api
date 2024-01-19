import 'dart:convert';

import 'package:flutter/foundation.dart';

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
    data["title"] = this.title;
    data["description"] = this.description;
    data["id"] = this.id;
    return data;
  }
}

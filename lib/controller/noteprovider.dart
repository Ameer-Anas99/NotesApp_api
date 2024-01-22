import 'package:flutter/material.dart';
import 'package:notes_app/model/notemodel.dart';
import 'package:notes_app/service/api_service.dart';

class NoteProvider extends ChangeNotifier {
  List<Map<String, String>> notes = [];
  TextEditingController notescontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  saveOnClick() {
    var notes = notescontroller.text.trim();
    var notedescription = descriptioncontroller.text.trim();
    final model = NoteModel(title: notes, description: notedescription, id: "");
    ApiService().createNotes(model);
    notifyListeners();
  }

  update(
      {required id, required String title, required String description}) async {
    final model = NoteModel(title: title, description: description, id: id);
    await ApiService().editNotes(value: model, id: id);
    notifyListeners();
  }

  deleteTodo({required id}) async {
    await ApiService().deleteNotes(id: id);
    notifyListeners();
  }
}

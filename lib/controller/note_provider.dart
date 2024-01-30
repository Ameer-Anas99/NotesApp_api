import 'package:flutter/material.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/service/api_service.dart';

class NoteProvider extends ChangeNotifier {
  List<Map<String, String>> notes = [];
  TextEditingController notescontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  ApiService service = ApiService();
  List<NoteModel> noteData = [];

  Future<void> fetchNotes() async {
    try {
      noteData = await service.fetchApi();
      notifyListeners();
    } catch (error) {
      print("Error fetching notes: $error");
    }
  }

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

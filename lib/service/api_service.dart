import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:notes_app/model/note_model.dart';

class ApiService {
  Dio dio = Dio();

  final url = "https://65ae17761dfbae409a73ed36.mockapi.io/study";
  Future<List<NoteModel>> fetchNotes() async {
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        List<NoteModel> notes = jsonList.map((e) {
          return NoteModel.fromJson(e);
        }).toList();
        return notes;
      } else {
        log("${response.statusCode}");
        throw Exception("Failed to fetch data");
      }
    } catch (error) {
      log("${error}");
      throw Exception("Failed to fetch: $error");
    }
  }

  createNotes(NoteModel value) async {
    try {
      await dio.post(url, data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  deleteNotes({required id}) async {
    var deleteurl = "https://65ae17761dfbae409a73ed36.mockapi.io/study/$id";
    try {
      await dio.delete(deleteurl);
    } catch (e) {
      throw Exception(e);
    }
  }

  editNotes({required value, required id}) async {
    try {
      await dio.put("https://65ae17761dfbae409a73ed36.mockapi.io/study/$id",
          data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}

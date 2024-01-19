import 'package:dio/dio.dart';
import 'package:notes_app/model/notemodel.dart';

class ApiService {
  Dio dio = Dio();

  final url = "https://659e512d47ae28b0bd358c64.mockapi.io/noteapp/note";
  Future<List<NoteModel>> fetchApi() async {
    try {
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        var jsonList = response.data as List;
        List<NoteModel> notes = jsonList.map((e) {
          return NoteModel.fromJson(e);
        }).toList();
        return notes;
      } else {
        throw Exception("Failed to fetch data");
      }
    } catch (error) {
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
    var deleteurl =
        "https://659e512d47ae28b0bd358c64.mockapi.io/noteapp/note/$id";
    try {
      await dio.delete(deleteurl);
    } catch (e) {
      throw Exception(e);
    }
  }

  editNotes({required value, required id}) async {
    try {
      await dio.put(
          "https://659e512d47ae28b0bd358c64.mockapi.io/noteapp/note/$id",
          data: value.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}

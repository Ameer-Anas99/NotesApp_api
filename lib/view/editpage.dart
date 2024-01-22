import 'package:flutter/material.dart';
import 'package:notes_app/controller/noteprovider.dart';
import 'package:notes_app/model/notemodel.dart';
import 'package:provider/provider.dart';

class EditPage extends StatefulWidget {
  final String title;
  final String description;
  final String id;
  const EditPage(
      {super.key,
      required this.title,
      required this.description,
      required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController notescontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();

  @override
  void initState() {
    notescontroller = TextEditingController(text: widget.title);
    descriptioncontroller = TextEditingController(text: widget.description);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EditAlertDialog(),
    );
  }

  AlertDialog EditAlertDialog() {
    final notespro = Provider.of<NoteProvider>(context);
    return AlertDialog(
      title: Text("Edit Notes"),
      content: SizedBox(
        height: 160,
        child: Column(
          children: [
            TextField(
              controller: notescontroller,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 18,
            ),
            TextField(
              controller: descriptioncontroller,
              decoration: InputDecoration(
                hintText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            notespro.update(
                id: widget.id,
                title: notescontroller.text,
                description: descriptioncontroller.text);
            Navigator.of(context).pop();
          },
          child: Text("Save"),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"))
      ],
    );
  }
}

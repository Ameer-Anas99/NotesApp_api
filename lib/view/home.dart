// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes_app/controller/note_provider.dart';
import 'package:notes_app/model/note_model.dart';
import 'package:notes_app/view/edit_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 238, 232, 232),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text("Notes App")),
      ),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () =>
              Provider.of<NoteProvider>(context, listen: false).fetchNotes(),
          child: Consumer<NoteProvider>(
            builder: (context, notepro, child) => FutureBuilder<void>(
              future: notepro.fetchNotes(),
              builder: (context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  List<NoteModel> notesData = notepro.noteData;
                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: notesData.length,
                    itemBuilder: (context, index) {
                      final noteData = notesData[index];
                      final note = noteData.title;
                      final description = noteData.description;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(22)),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SingleChildScrollView(
                                  child: Text(
                                    "Title :${note}" ?? "",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SingleChildScrollView(
                                  child: Text(
                                    "Description: ${description}" ?? "",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                          builder: (ctx) => EditPage(
                                            title: noteData.title,
                                            description: noteData.description,
                                            id: noteData.id,
                                          ),
                                        ));
                                      },
                                      icon: Icon(Icons.edit),
                                      color: Colors.green,
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        notepro.deleteTodo(id: noteData.id);
                                      },
                                      icon: Icon(Icons.delete),
                                      color: Colors.red,
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomCenter,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => adding(context),
            );
          },
          child: Text("Add"),
        ),
      ),
    );
  }

  AlertDialog adding(BuildContext context) {
    final noteprovider = Provider.of<NoteProvider>(context);
    return AlertDialog(
      title: Text("Add Notes"),
      content: SizedBox(
        height: 160,
        child: Column(
          children: [
            TextField(
              controller: noteprovider.notescontroller,
              decoration: InputDecoration(
                hintText: "Title",
                hintMaxLines: 1,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: noteprovider.descriptioncontroller,
              decoration: InputDecoration(
                  hintText: "Description",
                  hintMaxLines: 1,
                  border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              noteprovider.saveOnClick();
              noteprovider.notescontroller.clear();
              noteprovider.descriptioncontroller.clear();
              Navigator.of(context).pop();
            },
            child: Text("Save")),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text("Cancel"),
        )
      ],
    );
  }
}

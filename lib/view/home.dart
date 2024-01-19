// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes_app/model/notemodel.dart';
import 'package:notes_app/service/api_service.dart';
import 'package:notes_app/view/editpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, String>> notes = [];
  TextEditingController notescontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 40, 38, 38),
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Center(child: Text("Notes App")),
      ),
      body: RefreshIndicator(
        onRefresh: () => ApiService().fetchApi(),
        child: FutureBuilder(
          future: ApiService().fetchApi(),
          builder: (context, snapshot) => GridView.builder(
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final noteData = notes[index];
              final note = noteData;
              final description = noteData;

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(22)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Title :${note}" ?? "",
                        style: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Description: ${description}" ?? "",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (ctx) => EditPage(
                                  title: noteData,
                                  description: noteData,
                                  id: noteData,
                                ),
                              ));
                            },
                            icon: Icon(Icons.edit),
                            color: Colors.green,
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.delete),
                            color: Colors.red,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
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
    return AlertDialog(
      title: Text("Add Notes"),
      content: SizedBox(
        height: 160,
        child: Column(
          children: [
            TextField(
              controller: notescontroller,
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
              controller: descriptioncontroller,
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
              // setState(() {
              //   adddnotes();
              //   notescontroller.clear();
              //   descriptioncontroller.clear();
              // });
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

  // adddnotes() {
  //   String note = notescontroller.text;
  //   String description = descriptioncontroller.text;
  //   notes.add({"note": note, "description ": description});
  // }
}

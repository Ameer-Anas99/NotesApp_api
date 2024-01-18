import 'package:flutter/material.dart';

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
        title: Center(child: Text("Notes Api")),
      ),
      body: GridView.builder(
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: notes.length,
        itemBuilder: (context, index) {
          final noteData = notes[index];
          final note = noteData["note"];
          final description = noteData["description"];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(22)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Title :${note}" ?? "",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Description: ${description}" ?? "",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          );
        },
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
      content: Container(
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
              height: 20,
            ),
            TextField(
              controller: descriptioncontroller,
              decoration: InputDecoration(
                  hintText: "Description", border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
            onPressed: () {
              setState(() {
                adddnotes();
                notescontroller.clear();
                descriptioncontroller.clear();
              });
              Navigator.of(context).pop();
            },
            child: Text("Save")),
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cancel"))
      ],
    );
  }

  adddnotes() {
    String note = notescontroller.text;
    String description = descriptioncontroller.text;
    notes.add({"note": note, "description ": description});
  }
}

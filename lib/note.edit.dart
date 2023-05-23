import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/style.dart';

class noteEdit extends StatefulWidget {
  const noteEdit({super.key});

  @override
  State<noteEdit> createState() => _noteEditState();
}

class _noteEditState extends State<noteEdit> {
  int color = Random().nextInt(Appstyle.cardsColor.length);
  TextEditingController _titleController = TextEditingController();
  TextEditingController _mainController = TextEditingController();

  String date = DateTime.now().toString();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[color],
        elevation: 0.0,
        actionsIconTheme: IconThemeData(color: Colors.black),
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Add New Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Note Title',
            ),
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(date),
          SizedBox(
            height: 8.0,
          ),
          TextField(
            controller: _mainController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Note Content',
            ),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Appstyle.mainColor,
        foregroundColor: (Colors.white),
        onPressed: () async {
          FirebaseFirestore.instance.collection("Notes").add({
            "Title": _titleController,
            "createdAt": date,
            "Content": _mainController,
            "color": color
          }).then((value) {
            print(value.id);
            Navigator.pop(context);
          }).catchError((error) => print("Failed to add Note"));
        },
        child: Icon(Icons.save),
      ),
    );
  }
}

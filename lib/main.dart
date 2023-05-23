import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/note.card.dart';
import 'package:flutter_api/note.edit.dart';
import 'package:flutter_api/note.read.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade800),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.notes),
            SizedBox(width: 10),
            Text(
              'Note App',
              style: TextStyle(color: Colors.grey[850]),
            ),
          ],
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(' Your Memo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
          SizedBox(
            height: 20.0,
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream:
                  FirebaseFirestore.instance.collection('Notes').snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    children: snapshot.data!.docs
                        .map((QueryDocumentSnapshot<Map<String, dynamic>>
                                note) =>
                            noteCard(() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => noteReader(note)),
                              );
                            }, note))
                        .toList(),
                  );
                }
                return Text(
                  "There's no Notes",
                  style: TextStyle(fontWeight: FontWeight.bold),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => noteEdit()));
        },
        label: Text('Add Note'),
        icon: Icon(Icons.add),
      ),
    );
  }
}

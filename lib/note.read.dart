import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/style.dart';

class noteReader extends StatefulWidget {
  noteReader(this.doc, {Key? key}) : super(key: key);
  QueryDocumentSnapshot doc;
  @override
  State<noteReader> createState() => _noteReaderState();
}

class _noteReaderState extends State<noteReader> {
  @override
  Widget build(BuildContext context) {
    int color = widget.doc['color'];
    return Scaffold(
      backgroundColor: Appstyle.cardsColor[color],
      appBar: AppBar(
        backgroundColor: Appstyle.cardsColor[color],
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.doc['Title'],
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.start,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.doc['createdAt'],
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
              textAlign: TextAlign.start,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(
              height: 8.0,
            ),
            Text(
              widget.doc['Content'],
              style: TextStyle(fontSize: 14),
              textAlign: TextAlign.start,
            ),
          ],
        ),
      ),
    );
  }
}

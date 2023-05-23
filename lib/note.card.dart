import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: Appstyle.cardsColor[doc['color']],
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc['Title'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            doc['createdAt'],
            style: TextStyle(fontWeight: FontWeight.normal, fontSize: 14),
            textAlign: TextAlign.start,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 8.0,
          ),
          Text(
            doc['Content'],
            style: TextStyle(fontSize: 14),
            textAlign: TextAlign.start,
          ),
        ],
      ),
    ),
  );
}

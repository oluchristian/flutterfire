import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FireStoreService{
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future insertNote(String title, String description, String userId) async {
    try {
      await firestore.collection('notes').add(
       {
        'title': title, 
        "description": description, 
        "date":DateTime.now(), 
        "userId": userId
       }
        );
    } catch (e) {
      
    }
  }

  Future updateNote(String docId, String title, String description) async{
    try {
      await fireStore.collection('notes').doc(docId).Update([
        'title': title,
        'description': description,
      ]);
    } catch (e) {
      print(e);
    }
  }
}
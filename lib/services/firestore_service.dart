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
}
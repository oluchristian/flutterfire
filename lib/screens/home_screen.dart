import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/note.dart';
import 'package:flutter_firebase/screens/add_note.dart';
import 'package:flutter_firebase/screens/edit_note.dart';
import 'package:flutter_firebase/services/auth_service.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  HomeScreen({super.key, required this.user});
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        backgroundColor: Colors.pink,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await AuthService().signOut();
            },
            icon: Icon(Icons.logout),
            label: Text('sign out'),
            style: TextButton.styleFrom(primary: Colors.white),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('notes').where('userId', isEqualTo: user.uid).snapshots(),
        builder: (context, AsyncSnapshot snapshot){
          if (snapshot.hasData) {
            if (snapshot.data.docs.length > 0) {
              return ListView.builder(
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index){
                  NoteModel note = NoteModel.fromJson(snapshot.data.docs[index]);
                  return  Card(
            color: Colors.teal,
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 5,
              ),
              title: Text(
                note.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                note.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (context)=>EditNoteScreen(note: note,)));},
            ),
          );
                }
              );
            }else{
              return Center(
                child: Text('No Notes Available',),
              );
            }
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => AddNoteScreen(user: user,)));
        },
        backgroundColor: Colors.orangeAccent,
        child: Icon(Icons.add),
      ),
      
      
      );
  }
}

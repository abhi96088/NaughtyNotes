import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:naughty_notes/services/auth_service.dart';

class DatabaseService{

  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  final _user = AuthService().getInstance().currentUser;

  getInstance() => _fireStore;

  ///^^^^^^^^^^^^^^^^ Function to add or update notes ^^^^^^^^^^^^^^^^^^///
  void addOrUpdateNote({String? id, required String text, String? title}) async{

    // check if user is signed in
    if(_user == null) return;

    // reference of collection to add note
    CollectionReference notesCollection = _fireStore.collection('notes').doc(_user.uid).collection('notes_list');

    // check if id is provided to update note or has to add the note
    if(id == null){
      // add if id is not provided
      await notesCollection.add(
          {
            'title': title ?? '',
            'text':text,
            'timestamp': DateTime.now()
          }
      );
    } else {
      // update if id is provided
      await notesCollection.doc(id).update({
        'title': title ?? '',
        'text':text,
      });
    }
  }

  ///^^^^^^^^^^^^^^^^^^^^ Function to delete note ^^^^^^^^^^^^^^^^^^^///
  void deleteNote(String id) {
    // reference of note
    CollectionReference notesCollection = _fireStore.collection('notes').doc(_user.uid).collection('notes_list');
    notesCollection.doc(id).delete(); // delete note
  }

}
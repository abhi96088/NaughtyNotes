import 'package:animated_card/animated_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotesScreen extends StatefulWidget {
  const NotesScreen({super.key});

  @override
  State<NotesScreen> createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final CollectionReference notesCollection =
  FirebaseFirestore.instance.collection('notes');

  final List<Color> cardColors = [
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.purpleAccent,
  ];


  void _addOrUpdateNote({String? id}) {
    if (_noteController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Write something naughty first!", backgroundColor: Colors.red);
      return;
    }
    if (id == null) {
      notesCollection.add({
        'title': _titleController.text.isNotEmpty ? _titleController.text : '',
        'text': _noteController.text,
        'timestamp': DateTime.now()
      });
    } else {
      notesCollection.doc(id).update({
        'title': _titleController.text.isNotEmpty ? _titleController.text : '',
        'text': _noteController.text
      });
    }
    _titleController.clear();
    _noteController.clear();
  }

  void _deleteNote(String id) {
    notesCollection.doc(id).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Naughty Notes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: notesCollection.orderBy('timestamp', descending: true).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
            return MasonryGridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var doc = snapshot.data!.docs[index];
                var data = doc.data() as Map<String, dynamic>;
                String title = data['title'] ?? '';
                String text = data['text'] ?? '';
                String previewText = text.length > 50 ? '${text.substring(0, 50)}...' : text;
                Color cardColor = cardColors[doc.id.hashCode % cardColors.length];

                return AnimatedCard(
                  direction: index % 2 == 0 ? AnimatedCardDirection.left : AnimatedCardDirection.right,
                  child: GestureDetector(
                    onTap: () {
                      _showNoteDialog(context, title, text, doc.id);
                    },
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 3)),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (title.isNotEmpty)
                            Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          SizedBox(height: 5),
                          Text(previewText, style: TextStyle(fontSize: 18)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          _showAddOrEditDialog();
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showNoteDialog(BuildContext context, String title, String text, String docId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(title.isNotEmpty ? title : 'Note', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(text, style: TextStyle(fontSize: 18)),
        actions: [
          TextButton(
            onPressed: () {
              _showAddOrEditDialog(id: docId, existingTitle: title, existingText: text);
            },
            child: Text('Edit', style: TextStyle(color: Colors.blue)),
          ),
          TextButton(
            onPressed: () {
              _deleteNote(docId);
              Navigator.pop(context);
            },
            child: Text('Delete', style: TextStyle(color: Colors.red)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close', style: TextStyle(color: Colors.pinkAccent)),
          ),
        ],
      ),
    );
  }

  void _showAddOrEditDialog({String? id, String? existingTitle, String? existingText}) {
    _titleController.text = existingTitle ?? '';
    _noteController.text = existingText ?? '';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        title: Text(id == null ? 'New Naughty Note' : 'Edit Naughty Note', style: TextStyle(fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter title (optional)...',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _noteController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter your naughty note...',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _addOrUpdateNote(id: id);
              Navigator.pop(context);
            },
            child: Text(id == null ? 'Save' : 'Update', style: TextStyle(color: Colors.pinkAccent)),
          ),
        ],
      ),
    );
  }
}

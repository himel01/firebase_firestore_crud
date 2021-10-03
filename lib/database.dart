import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference students =
    FirebaseFirestore.instance.collection('students');

class Database {
  static String? documentId;

  static Future<void> addUser(String name, String age, String id) {
    // Call the user's CollectionReference to add a new user
    return students
        .doc(id)
        .set({'name': name, 'age': age, 'id': id})
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  static delete(String id) {
    students
        .doc(id)
        .delete()
        .then((value) => print('Deleted'))
        .catchError((error) => print('Delete failed: $error'));
  }
}

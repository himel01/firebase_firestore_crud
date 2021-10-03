// import 'package:cloud_firestore/cloud_firestore.dart';
//
// final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// final CollectionReference _mainCollection = _firestore.collection('students');
//
// class Database {
//   static String? studentId;
//
//   // static Future<void> addItem({
//   //   required String name,
//   //   required String age,
//   // }) async {
//   //   DocumentReference documentReferencer =
//   //       _mainCollection.doc(studentId).collection('items').doc();
//   //
//   //   Map<String, dynamic> data = <String, dynamic>{
//   //     "name": name,
//   //     "age": age,
//   //   };
//   //
//   //   await documentReferencer
//   //       .set(data)
//   //       .whenComplete(() => print("Student added to database"))
//   //       .catchError((e) => print(e));
//   // }
//  static Future<void> addUser(String name,String age) {
//     // Call the user's CollectionReference to add a new user
//     return _mainCollection
//         .add({
//       'name': name,
//
//       'age': age
//     })
//         .then((value) => print("User Added"))
//         .catchError((error) => print("Failed to add user: $error"));
//   }
//   static Stream<QuerySnapshot> readItems() {
//     CollectionReference notesItemCollection =
//     _mainCollection.doc(studentId).collection('items');
//
//     return notesItemCollection.snapshots();
//   }
//
//   static Future<void> updateItem({
//     required String name,
//     required String age,
//     required String docId,
//   }) async {
//     DocumentReference documentReferencer =
//     _mainCollection.doc(studentId).collection('items').doc(docId);
//
//     Map<String, dynamic> data = <String, dynamic>{
//       "name": name,
//       "age": age,
//     };
//
//     await documentReferencer
//         .update(data)
//         .whenComplete(() => print("Student info updated"))
//         .catchError((e) => print(e));
//   }
//
//   static Future<void> deleteItem({
//     required String docId,
//   }) async {
//     DocumentReference documentReferencer =
//     _mainCollection.doc(studentId).collection('items').doc(docId);
//
//     await documentReferencer
//         .delete()
//         .whenComplete(() => print('Note item deleted from the database'))
//         .catchError((e) => print(e));
//   }
// }
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

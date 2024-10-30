import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  // Set data at the document path
  Future<void> set({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data, SetOptions(merge: true));
  }

  // Update data at the document path
  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update(data);
  }

  // Delete data at the document path
  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.delete();
  }

  // Stream a single document
  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.doc(path);
    return reference.snapshots().map((snapshot) {
      if (!snapshot.exists) {
        throw Exception('Document does not exist');
      }
      return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
    });
  }

  // Stream a collection
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final reference = FirebaseFirestore.instance.collection(path);
    return reference.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => builder(doc.data(), doc.id)).toList());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  FirestoreService._();
  static final instance = FirestoreService._();

  Future<void> set(
      {required String path, required Map<String, dynamic> data}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.set(data);
  }

  Future<void> update({
    required String path,
    required Map<String, dynamic> data,
  }) async {
    final reference = FirebaseFirestore.instance.doc(path);
    await reference.update(data);
  }

  Future<void> deleteData({required String path}) async {
    final reference = FirebaseFirestore.instance.doc(path);
    print('delete: $path');
    // print('delete: $path');
  }

  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final DocumentReference reference = FirebaseFirestore.instance.doc(path);
    final Stream<DocumentSnapshot> snapshots = reference.snapshots();

    return snapshots.map((snapshot) {
      if (!snapshot.exists) {
        throw Exception(
            'Document does not exist'); // Handle non-existent document
      }
      // Assuming the data is guaranteed to be a Map<String, dynamic>
      return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
    });
  }

  Stream<List<T>> collectionStream<T>({
    required String path,
    required T builder(Map<String, dynamic> data, String documentID),
  }) {
    final CollectionReference reference =
        FirebaseFirestore.instance.collection(path);
    final Stream<QuerySnapshot> snapshots = reference.snapshots();
    return snapshots.map((snapshot) => snapshot.docs
        .map((doc) => builder(doc.data() as Map<String, dynamic>, doc.id))
        .toList());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:book_shopping_app/model/cart_model.dart';
import 'package:book_shopping_app/model/user_model.dart';
import 'package:book_shopping_app/services/firestore_services.dart';
import 'package:book_shopping_app/services/firestore_path.dart';

class FirestoreDatabase {
  FirestoreDatabase({required this.uid, required this.cartId});
  final String uid;
  final String cartId;
  final _firestoreService = FirestoreService.instance;

  // Create or update a CartModel
  Future<void> setCart(CartModel cart) async {
    try {
      await _firestoreService.set(
        path: FirestorePath.cart(uid, cartId),
        data: cart.toMap(),
      );
      print('Cart data saved with ID: $cartId');
    } catch (e) {
      print('Error saving cart: $e');
    }
  }

  // Retrieve CartModel as a stream
  Stream<List<CartModel>> cartStream() {
    return _firestoreService.collectionStream(
      path: FirestorePath.cart(uid, cartId),
      builder: (data, docId) => CartModel.fromMap(data, docId),
    );
  }

  // Delete a CartModel
  Future<void> deleteCart() async {
    try {
      await _firestoreService.deleteData(path: FirestorePath.cart(uid, cartId));
      print('Cart deleted with ID: $cartId');
    } catch (e) {
      print('Error deleting cart: $e');
    }
  }

  // Create or update a UserModel
  Future<void> setUser(UserModel user) async {
    try {
      await _firestoreService.set(
        path: FirestorePath.user(uid),
        data: user.toMap(),
      );
      print('User data saved for UID: ${user.uid}');
    } catch (e) {
      print('Error saving user: $e');
    }
  }

  // Retrieve UserModel as a stream
  Stream<UserModel> userStream() {
    return _firestoreService.documentStream(
      path: FirestorePath.user(uid),
      builder: (data, docId) => UserModel.fromMap(data, docId),
    );
  }
}

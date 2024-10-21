import 'dart:math';

import 'package:book_shopping_app/model/cart_model.dart';
import 'package:book_shopping_app/model/user_model.dart';
import 'package:book_shopping_app/services/firestore_path.dart';
import 'package:book_shopping_app/services/firestore_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreDatabase {
  FirestoreDatabase({required this.uid, required this.cartId});
  final String uid;
  final String cartId;
  final _firestoreService = FirestoreService.instance;
// Method to create/update CartModel
  Future<void> setCart(CartModel cart) async {
    print('Saving cart data: ${cart.toMap()}');

// print('Savig cart data: ${cart.toMap()}');
    try {
// Saving cart data under user's cart collection
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('cart')
          .doc(cartId)
          .set(cart.toMap(), SetOptions(merge: true));
      print('Cart data saved with ID: $cartId');
    }
// print('Cart data saved with ID: $cartId');
    catch (e) {
      print('Error saving cart: $e');
// print('Error saving cart: $e');
    }
  }

// Method to retrieve CartModel based on the user's cart collection
  Stream<List<CartModel>> cartStream() {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => CartModel.fromMap(doc.data(), doc.id))
            .toList());
  }

// Method to delete a cart (you may want to provide a cartId for this)
  Future<void> deleteCart(String cartId) async {
    try {
      await _firestoreService.deleteData(path: FirestorePath.cart(uid, cartId));

      print('Cart deleted with ID: $cartId');
// print('Cart deleted with ID: $cartId');
    } catch (e) {
      print('Error deleting cart: $e');
// print('Error deleting cart: $e');
    }
  }

// Method to create/update UserModel
  Future<void> setUser(UserModel user) async {
    try {
      await _firestoreService.set(
        path: FirestorePath.user(uid),
        data: user.toMap(),
      );
      print('User data saved for UID: ${user.uid}');
    }
// print('User data saved for UID: ${user.uid}');
    catch (e) {
      print('Error saving user: $e');
// print('Error saving user: $e');
    }
  }

// Method to retrieve UserModel based on the given userId
  Stream<UserModel> userStream() => _firestoreService.documentStream(
        path: FirestorePath.user(uid),
        builder: (data, documentId) => UserModel.fromMap(data, documentId),
      );
// Method to add a cart item
  Future<void> addCartItem(String cartItemId, CartModel cartItem) async {
    try {
      await _firestoreService.set(
        path: FirestorePath.cartItem(uid, cartItemId),
        data: cartItem.toMap(),
      );

      print('Cart item added with ID: $cartItemId');
    }
// print('Cart item added with ID: $cartItemId');
    catch (e) {
      print('Error adding cart item: $e');
// print('Error adding cart item: $e');
    }
  }

// Method to remove a cart item
  Future<void> removeCartItem(String cartItemId) async {
    try {
      await _firestoreService.deleteData(
          path: FirestorePath.cartItem(uid, cartItemId));
      print('Cart item removed with ID: $cartItemId');
    }
// print('Cart item removed with ID: $cartItemId');
    catch (e) {
      print('Error removing cart item: $e');
// print('Error removing cart item: $e');
    }
  }
}

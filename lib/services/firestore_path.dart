class FirestorePath {
  // Path for a user document
  static String user(String uid) => 'users/$uid';

  // Path for a cart collection
  static String cart(String uid, String cartId) => 'users/$uid/cart';

  // Path for a single cart item
  static String cartItem(String uid, String cartItemId) =>
      'users/$uid/cart/$cartItemId';
}

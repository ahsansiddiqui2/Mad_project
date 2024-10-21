class FirestorePath {
  static String user(String uid) => 'users/$uid';
  static String cart(String uid, String cartId) =>
      'users/$uid/cart'; // This is the cart collection for a user
  static String cartItem(String uid, String cartItemId) =>
      'users/$uid/cart/$cartItemId'; // Each cart item document
}

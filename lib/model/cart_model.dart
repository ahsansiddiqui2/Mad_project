import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<List<dynamic>> fic_Items = [
    [
      "The Great Gatsby",
      "999",
      "lib/images/fiction/thegreatgatsby.jpeg",
      Colors.green
    ],
    [
      "A Death in Tokyo",
      "559",
      "lib/images/fiction/deathintokyo.jpg",
      Colors.yellow
    ],
    [
      "The Girl in Room 105",
      "1999",
      "lib/images/fiction/thegirl105.jpg",
      Colors.yellow
    ],
    [
      "Looking For Alaska",
      "1999",
      "lib/images/fiction/lookingforalaska.jpg",
      Colors.green
    ],
    [
      "The Course of True Love",
      "699",
      "lib/images/fiction/thecourse.jpeg",
      Colors.green
    ],
    ["Beloved", "799", "lib/images/fiction/beloved.jpeg", Colors.yellow],
    ["The Color Purple", "950", "lib/images/fiction/color.jpg", Colors.yellow],
    ["Catch 22", "1250", "lib/images/fiction/catch.jpg", Colors.yellow],
  ];

  final List<List<dynamic>> com_Items = [
    ["The Naruto, Vol 1", "299", "lib/images/comics/naruto.jpg", Colors.green],
    ["The Spiderman", "559", "lib/images/comics/spiderman.jpg", Colors.yellow],
    ["Sunshine", "999", "lib/images/comics/sunshine.jpg", Colors.yellow],
    ["The Wolverine", "799", "lib/images/comics/wolverine.jpg", Colors.green],
    [
      "Batman In the Bronze Age",
      "1200",
      "lib/images/comics/batman1.jpg",
      Colors.yellow
    ],
    [
      "The Marvel Encyclopedia",
      "1000",
      "lib/images/comics/marvel.jpg",
      Colors.yellow
    ],
    ["Extremis", "1700", "lib/images/comics/iron_man.jpg", Colors.green],
    [
      "These Savage Shores",
      "1700",
      "lib/images/comics/savage.jpg",
      Colors.green
    ],
  ];

  final List<List<dynamic>> fan_Items = [
    ["The Dracula", "299", "lib/images/fantasy/dracula.jpg", Colors.green],
    ["The Last Dog", "559", "lib/images/fantasy/thelastdog.jpg", Colors.yellow],
    [
      "The Magic Factory",
      "999",
      "lib/images/fantasy/themagic.jpg",
      Colors.yellow
    ],
    [
      "A Game of Thrones",
      "1100",
      "lib/images/fantasy/game_of_throne.jpg",
      Colors.green
    ],
    ["The Hobbit", "850", "lib/images/fantasy/the_hobbit.jpg", Colors.green],
    [
      "Northern Lights",
      "1300",
      "lib/images/fantasy/northern_lights.jpg",
      Colors.yellow
    ],
    [
      "The Princess Bride",
      "1000",
      "lib/images/fantasy/princess_bride.jpg",
      Colors.green
    ],
    [
      "Children of Virtue And Vengeance",
      "2000",
      "lib/images/fantasy/children.jpg",
      Colors.yellow
    ],
  ];

  List<Map<String, dynamic>> _cartItems = []; // Changed to a list of maps

  List<Map<String, dynamic>> get cartItems => _cartItems;

  List<List<dynamic>> get shopItems => fic_Items;
  List<List<dynamic>> get comicItems => com_Items;
  List<List<dynamic>> get fanItems => fan_Items;

  // Fiction
  void addItemToCart(int index) {
    _cartItems.add({
      'title': fic_Items[index][0],
      'price': fic_Items[index][1],
      'image': fic_Items[index][2],
      'color': fic_Items[index][3]
          .toString(), // Convert Color to String if necessary
    });
    notifyListeners();
  }

  // Comics
  void addItemToCartCom(int index) {
    _cartItems.add({
      'title': com_Items[index][0],
      'price': com_Items[index][1],
      'image': com_Items[index][2],
      'color': com_Items[index][3].toString(),
    });
    notifyListeners();
  }

  // Fantasy
  void addItemToCartFan(int index) {
    _cartItems.add({
      'title': fan_Items[index][0],
      'price': fan_Items[index][1],
      'image': fan_Items[index][2],
      'color': fan_Items[index][3].toString(),
    });
    notifyListeners();
  }

  // Remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (var item in cartItems) {
      totalPrice += double.parse(item['price']);
    }
    return totalPrice.toStringAsFixed(2);
  }

  // Convert CartModel to Map
  Map<String, dynamic> toMap() {
    return {
      'cartItems': _cartItems,
    };
  }

  // Convert Map to CartModel
  static CartModel fromMap(Map<String, dynamic> map, String documentId) {
    return CartModel()
      .._cartItems = (map['cartItems'] as List<dynamic>? ?? []).map((item) {
        return item as Map<String, dynamic>; // Explicitly cast to Map
      }).toList();
  }

  Future<void> saveCartData(String uid) async {
    try {
      // Reference to the Firestore document
      DocumentReference docRef =
          FirebaseFirestore.instance.collection('carts').doc(uid);

      // Saving the cart data
      await docRef.set(
          toMap(), SetOptions(merge: true)); // Use toMap() for cart items

      print('Cart saved successfully');
    } catch (e) {
      print('Error saving cart: $e');
      // Handle error appropriately
    }
  }
}

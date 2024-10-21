import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List fic_Items = [
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
    ["Catch 22", "1250", "lib/images/fiction/catch.jpg", Colors.yellow]
  ];

  final List com_Items = [
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
    ]
  ];

  final List fan_Items = [
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

  List _cartItems = [];
  get cartItems => _cartItems;

  get shopItems => fic_Items;
  get comicItems => com_Items;
  get fanItems => fan_Items;

  // Fiction
  void addItemToCart(int index) {
    _cartItems.add(fic_Items[index]);
    notifyListeners();
  }

  // Comics
  void addItemToCartCom(int index) {
    _cartItems.add(com_Items[index]);
    notifyListeners();
  }

  // Fantasy
  void addItemToCartFan(int index) {
    _cartItems.add(fan_Items[index]);
    notifyListeners();
  }

  // remove item from cart
  void removeItemFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  String calculateTotal() {
    double totalPrice = 0;
    for (int i = 0; i < cartItems.length; i++) {
      totalPrice += double.parse(cartItems[i][1]);
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
        return item as List<dynamic>; // Explicitly cast each item in the list
      }).toList();
  }
}

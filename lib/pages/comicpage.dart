import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/cart_model.dart';
import '../pages/cart_page.dart';

class ComicPage extends StatelessWidget {
  const ComicPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String uid = "user_uid"; // Replace this with the actual user UID

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Comic Collection",
          style: TextStyle(
              color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const CartPage()),
            ),
            icon: const Icon(Icons.shopping_bag_rounded, color: Colors.black),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const CartPage()),
        ),
        backgroundColor: Colors.black,
        child: const Icon(Icons.shopping_bag_rounded),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Welcome to the Comic World!",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                const Text(
                  "Explore Our Collection of Iconic Comic Books",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(thickness: 2),
                const SizedBox(height: 20),
                const Text(
                  "Discover amazing stories and iconic heroes in our curated Comic Book collection!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 20),

                // Featured Comic Books Section
                const Text(
                  "Featured Comic Books",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),

                // Grid of Comic Books
                Consumer<CartModel>(
                  builder: (context, value, child) {
                    return GridView.builder(
                      itemCount: value.com_Items.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7, // Adjusted for better visuals
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.asset(
                                    value.com_Items[index][2],
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  value.com_Items[index][0],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Text(
                                  "\Rs.${value.com_Items[index][1]}",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Add item to cart
                                  Provider.of<CartModel>(context, listen: false)
                                      .addItemToCartCom(index);

                                  // Save cart data to Firestore
                                  Provider.of<CartModel>(context, listen: false)
                                      .saveCartData(uid);

                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${value.com_Items[index][0]} added to cart!'),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Add to Cart',
                                  style: TextStyle(color: Colors.purple),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

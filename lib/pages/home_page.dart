import 'package:book_shopping_app/pages/Login_page.dart';
import 'package:book_shopping_app/pages/cart_page.dart';
import 'package:book_shopping_app/pages/comicpage.dart';
import 'package:book_shopping_app/pages/fantasypage.dart';
import 'package:book_shopping_app/pages/fictionpage.dart';
import 'package:book_shopping_app/provider/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Welcome to the Book Store!",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () {
              // Show a confirmation dialog
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm Sign Out"),
                    content: const Text("Do you really want to sign out?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Close the dialog
                          Navigator.of(context).pop();
                        },
                        child: const Text("No"),
                      ),
                      TextButton(
                        onPressed: () {
                          // Call the signOut method
                          authProvider.signOut();
                          // Navigate to the login page after logout
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: const Text("Yes"),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.logout, color: Colors.black),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CartPage(),
          ),
        ),
        backgroundColor: Colors.purpleAccent,
        child: const Icon(Icons.shopping_bag_rounded),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Category Filter
            Container(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryChip(context, "Fiction",
                      page: const FictionPage()),
                  _buildCategoryChip(context, "Comics", page: ComicPage()),
                  _buildCategoryChip(context, "Fantasy",
                      page: const FantasyPage()),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Popular Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Popular",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Popular Book Cards
            Container(
              height: 250,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: 0.65,
                children: [
                  _buildPopularBookCard(
                      "A Court of Thorns and Roses", "lib/images/fiction.jpg"),
                  _buildPopularBookCard(
                      "A Court of Mist and Fury", "lib/images/fantasy.jpg"),
                  _buildPopularBookCard(
                      "Thorn and Roses", "lib/images/comic.jpg"),
                  _buildPopularBookCard(
                      "A Death At the Party", "lib/images/fiction1.jpg"),
                  _buildPopularBookCard("Circe", "lib/images/fantasy1.jpg"),
                  _buildPopularBookCard(
                      "The Avengers: Earth's Mightiest Heroes",
                      "lib/images/comics1.jpg"),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // eBooks Section
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "eBooks",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // eBooks List
            Container(
              height: 250,
              child: GridView.count(
                scrollDirection: Axis.horizontal,
                crossAxisCount: 1,
                childAspectRatio: 0.65,
                children: [
                  _buildPopularBookCard(
                      "The Catcher in the Rye", "lib/images/ebook_1.jpg"),
                  _buildPopularBookCard(
                      "Pride and Prejudice", "lib/images/ebook2.jpg"),
                  _buildPopularBookCard("Moby Dick", "lib/images/ebook_3.jpg"),
                  _buildPopularBookCard(
                      "War and Peace", "lib/images/ebook4.jpg"),
                  _buildPopularBookCard("The Odyssey", "lib/images/ebook5.jpg"),
                  _buildPopularBookCard(
                      "Crime and Punishment", "lib/images/ebook6.jpg"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Method to build category chips
  Widget _buildCategoryChip(BuildContext context, String title,
      {Widget? page}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: InkWell(
        onTap: () {
          if (page != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => page),
            );
          }
        },
        child: Chip(
          label: Text(title),
          backgroundColor: Colors.purpleAccent.withOpacity(0.2),
        ),
      ),
    );
  }

  // Method to build popular book cards
  Widget _buildPopularBookCard(String title, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          width: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.transparent, Colors.black54],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

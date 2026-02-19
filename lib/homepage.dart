// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:uijaffazapp/screens/details_screen.dart';
import 'package:uijaffazapp/screens/login.dart';
import 'package:uijaffazapp/screens/my_order_screen.dart';
import 'package:uijaffazapp/services/api_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<CartItem> cartItems = [];

  List categories = [];
  List foodItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final catData = await ApiService.fetchCategories();
      final foodData = await ApiService.fetchFoodItems();

      setState(() {
        categories = catData;
        foodItems = foodData;
        isLoading = false;
      });
    } catch (e) {
      debugPrint("API ERROR: $e");
      setState(() => isLoading = false);
    }
  }

  void addToCart(CartItem item) {
    final index = cartItems.indexWhere((e) => e.title == item.title);
    setState(() {
      if (index >= 0) {
        cartItems[index].quantity++;
      } else {
        cartItems.add(item);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: primaryGreen,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MyOrderScreen(cartItems: cartItems),
              ),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: ''),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    const Text(
                      "Food Category",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    
                    SizedBox(
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final cat = categories[index];
                          return CategoryChip(
                            title: cat['name'],
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Popular",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),

                    
                    Expanded(
                      child: GridView.builder(
                        itemCount: foodItems.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 13,
                          crossAxisSpacing: 13,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (context, index) {
                          final item = foodItems[index];
return InkWell(
  borderRadius: BorderRadius.circular(20),
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>  DetailsScreen(foodItem: item),
      ),
    );
  },
  child: ProductCard(
    title: item['name'],
    rating: "5.0",
    price: item['price'].toString(),
    imageUrl: item['image'] ?? '',
    onAdd: () {
      addToCart(
        CartItem(
          title: item['name'],
          image: item['image'] ?? '',
          price: double.parse(item['price'].toString()),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              MyOrderScreen(cartItems: cartItems),
        ),
      );
    },
  ),
);

                        },
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class CategoryChip extends StatelessWidget {
  final String title;

  const CategoryChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.center,
      child:
          Text(title, style: const TextStyle(color: Colors.green)),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String rating;
  final String price;
  final String imageUrl;
  final VoidCallback onAdd;

  const ProductCard({
    super.key,
    required this.title,
    required this.rating,
    required this.price,
    required this.imageUrl,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final Color primaryGreen = Theme.of(context).primaryColor;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),

        Expanded(
  child: Image.network(
    imageUrl.startsWith("http")
        ? imageUrl.replaceAll("127.0.0.1", "localhost")
        : "http://localhost:8000/storage/$imageUrl",
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) {
      return const Icon(Icons.fastfood, size: 60);
    },
  ),
),





          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.star, color: primaryGreen, size: 16),
              const SizedBox(width: 4),
              Text(rating),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(price,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              InkWell(
                onTap: onAdd,
                child: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

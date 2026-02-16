import 'package:flutter/material.dart';


class MyOrderScreen extends StatefulWidget {
  final List<CartItem> cartItems;

  const MyOrderScreen({super.key, required this.cartItems});

  @override
  State<MyOrderScreen> createState() => _MyOrderScreenState();
}

class _MyOrderScreenState extends State<MyOrderScreen> {
  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).primaryColor;

    final bool isEmpty = widget.cartItems.isEmpty;

    final double total = widget.cartItems.fold(
      0,
      (sum, item) => sum + item.total,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            /// 🔝 APP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "My Order",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.delete_outline),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// 🧾 CONTENT
            Expanded(
              child: isEmpty
                  ? _emptyCartUI()
                  : ListView.builder(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: widget.cartItems.length,
                      itemBuilder: (context, index) {
                        final item = widget.cartItems[index];
                        return _orderItem(
                          item: item,
                          green: green,
                          onAdd: () {
                            setState(() => item.quantity++);
                          },
                          onRemove: () {
                            setState(() {
                              if (item.quantity > 1) {
                                item.quantity--;
                              } else {
                                widget.cartItems.removeAt(index);
                              }
                            });
                          },
                        );
                      },
                    ),
            ),

            /// 💰 TOTAL (sirf tab jab cart empty na ho)
            if (!isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const Divider(),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "\$${total.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Container(
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: green,
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                      alignment: Alignment.center,
                      child: const Text(
                        "Proceed to Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// 🧾 SINGLE ITEM
  Widget _orderItem({
    required CartItem item,
    required Color green,
    required VoidCallback onAdd,
    required VoidCallback onRemove,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
        color: Colors.white,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              item.image,
              height: 60,
              width: 60,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    IconButton(
                      icon:
                          const Icon(Icons.remove, size: 16),
                      onPressed: onRemove,
                    ),
                    Text("${item.quantity}",
                        style: const TextStyle(
                            fontWeight: FontWeight.bold)),
                    IconButton(
                      icon:
                          const Icon(Icons.add, size: 16),
                      onPressed: onAdd,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Text(
            "\$${item.total.toStringAsFixed(2)}",
            style: TextStyle(
              color: green,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  /// 🛒 EMPTY CART UI
  Widget _emptyCartUI() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.shopping_cart_outlined,
              size: 80, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            "Your cart is empty",
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 6),
          Text(
            "Add some delicious food 🍔🍕",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
class CartItem {
  final String title;
  final String image;
  final double price;
  int quantity;

  CartItem({
    required this.title,
    required this.image,
    required this.price,
    this.quantity = 1,
  });

  double get total => price * quantity;
}

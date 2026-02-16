import 'package:flutter/material.dart';

class FriesDetailscreen extends StatefulWidget {
  const FriesDetailscreen({super.key});

  @override
  State<FriesDetailscreen> createState() => _FriesDetailscreenState();
}

class _FriesDetailscreenState extends State<FriesDetailscreen> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    final green = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Column(
          children: [
            /// 🔝 TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context); // ✅ correct back
                    },
                  ),
                  const Text(
                    "Details",
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const Icon(Icons.more_horiz),
                ],
              ),
            ),

            const SizedBox(height: 10),

            /// 🍟 IMAGE
            Image.asset(
              'assets/images/fries.png',
              height: 180,
              fit: BoxFit.contain,
            ),

            const SizedBox(height: 16),

            /// ⬜ DETAILS CARD
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// TITLE + PRICE
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "French Fries",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "\$2.55",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 8),

                      /// ⭐ RATING
                      Row(
                        children: const [
                          Icon(Icons.star, color: Colors.green, size: 18),
                          SizedBox(width: 4),
                          Text("5.0"),
                          SizedBox(width: 6),
                          Text(
                            "(2.5k Reviews)",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      /// 📄 DESCRIPTION
                      const Text(
                        "Description",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Golden crispy french fries made from fresh potatoes "
                        "and cooked to perfection. Lightly salted and served hot "
                        "for a delicious crunch in every bite.\n\n"
                        "Perfect as a snack or side with your favorite meal.",
                        style: TextStyle(color: Colors.grey, height: 1.4),
                      ),

                      const SizedBox(height: 20),

                      /// ➕➖ QUANTITY
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove),
                                  onPressed: () {
                                    if (quantity > 1) {
                                      setState(() => quantity--);
                                    }
                                  },
                                ),
                                Text(
                                  "$quantity",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    setState(() => quantity++);
                                  },
                                ),
                              ],
                            ),
                          ),
                          const Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: Colors.green, size: 18),
                              SizedBox(width: 6),
                              Text("Free Shipping"),
                            ],
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      /// 🟢 ACTION BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context); // ✅ back to Home
                          },
                          child: const Text(
                            "Back to Home",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

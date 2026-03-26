import 'package:flutter/material.dart';
import '../models/product.dart';
import '../data/dummy_data.dart';
import '../widgets/product_card.dart';

class DetailsScreen extends StatelessWidget {
  final Product product;
  const DetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final relatedProducts = dummyProducts
        .where((p) => p.category == product.category && p.id != product.id)
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(product.category, style: const TextStyle(fontSize: 16)),
        actions: [
          IconButton(icon: const Icon(Icons.favorite_border, size: 22), onPressed: () {}),
          IconButton(icon: const Icon(Icons.share_outlined, size: 22), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. MODERATE IMAGE HEIGHT (Reduced from 400 to 320)
            Hero(
              tag: product.id,
              child: Image.network(
                product.image,
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. COMPACT TITLE & PRICE ROW
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "₦${product.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.brown,
                        ),
                      ),
                    ],
                  ),

                  // 3. MINIMAL RATING
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 14),
                      const SizedBox(width: 4),
                      Text("4.5", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                      const SizedBox(width: 4),
                      Text("(12 reviews)", style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
                    ],
                  ),

                  const Divider(height: 30),

                  // 4. CLEANER SPECS SECTION
                  const Text(
                    "Information",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  _buildCompactSpec("Condition", "Grade A Thrift"),
                  _buildCompactSpec("Material", "Premium Cotton"),
                  _buildCompactSpec("Delivery", "Nationwide"),

                  const SizedBox(height: 20),

                  // 5. MODERATE DESCRIPTION
                  const Text(
                    "Description",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.description,
                    style: TextStyle(fontSize: 14, color: Colors.grey.shade700, height: 1.4),
                  ),

                  const SizedBox(height: 25),

                  // 6. PROFESSIONAL ACTION BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 50, // Slightly shorter
                    child: ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Added to Bag"), duration: Duration(seconds: 1)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                      child: const Text("ADD TO CART", style: TextStyle(letterSpacing: 1.1)),
                    ),
                  ),

                  const SizedBox(height: 35),

                  // 7. COMPACT RELATED PRODUCTS
                  if (relatedProducts.isNotEmpty) ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Similar Items",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        TextButton(onPressed: () {}, child: const Text("See All", style: TextStyle(fontSize: 12))),
                      ],
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 220, // Reduced height
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: relatedProducts.length,
                        itemBuilder: (context, index) {
                          final item = relatedProducts[index];
                          return Container(
                            width: 140, // Narrower cards
                            margin: const EdgeInsets.only(right: 12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => DetailsScreen(product: item)),
                                );
                              },
                              child: ProductCard(product: item),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Smaller, moderate spec row
  Widget _buildCompactSpec(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
    );
  }
}
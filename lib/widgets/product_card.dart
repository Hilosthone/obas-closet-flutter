import 'package:flutter/material.dart';
import '../models/product.dart';
import '../screens/details_screen.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailsScreen(product: product),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12), // Moderate rounding
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04), // Subtle, pro shadow
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. SMART LOADING IMAGE
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Hero(
                  tag: product.id, // For smooth transition to DetailsScreen
                  child: Image.network(
                    // PRO TIP: Added w=400 to the URL to download smaller, faster images
                    "${product.image}?auto=compress&cs=tinysrgb&w=400",
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // Error state
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey.shade100,
                      child: const Icon(Icons.broken_image_outlined, color: Colors.grey),
                    ),
                    // Professional "Shimmer" placeholder
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return _buildShimmerEffect();
                    },
                  ),
                ),
              ),
            ),

            // 2. COMPACT DETAILS
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13, // Moderate font size
                      color: Color(0xFF2D2D2D),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "₦${product.price.toStringAsFixed(0)}",
                        style: const TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      // Minimalist Add Button
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Added ${product.name}"),
                              behavior: SnackBarBehavior.floating,
                              duration: const Duration(seconds: 1),
                              backgroundColor: Colors.brown.shade800,
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.brown.shade50,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Icon(Icons.add, color: Colors.brown, size: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // BUILDER: A clean, moderate shimmer placeholder
  Widget _buildShimmerEffect() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade200,
            Colors.grey.shade100,
            Colors.grey.shade200,
          ],
          begin: const Alignment(-1, -1),
          end: const Alignment(1, 1),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';
import '../widgets/home_advert_section.dart';
import '../data/dummy_data.dart';
import 'details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedCategory = "All";
  String searchQuery = "";
  final List<String> categories = ["All", "Shirts", "Gowns", "Jeans", "Corporate"];

  @override
  Widget build(BuildContext context) {
    // Advanced filtering logic
    final filteredProducts = dummyProducts.where((product) {
      final matchesCategory = selectedCategory == "All" || product.category == selectedCategory;
      final matchesSearch = product.name.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFFDF8F5),
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          "OBA’S CLOSET",
          style: TextStyle(fontSize: 16, letterSpacing: 1.5, fontWeight: FontWeight.bold),
        ),
        actions: [
          _buildCartBadge(),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // 1. FIXED SEARCH BAR
          _buildSearchBar(),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 2. EXTERNAL ADVERT COMPONENT (Banner, Service Info, Quick Actions)
                  const HomeAdvertSection(),

                  // 3. CATEGORY SECTION
                  const Padding(
                    padding: EdgeInsets.fromLTRB(16, 15, 16, 10),
                    child: Text(
                      "Shop by Category",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                    ),
                  ),
                  _buildCategoryList(),

                  // 4. DYNAMIC PRODUCT GRID HEADER
                  Padding(
                    padding: const EdgeInsets.fromLTRB(18, 25, 18, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          selectedCategory == "All" ? "Recommended for You" : selectedCategory,
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        if (searchQuery.isEmpty)
                          Text(
                            "${filteredProducts.length} items",
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                      ],
                    ),
                  ),

                  // 5. PRODUCT GRID
                  filteredProducts.isEmpty
                      ? SizedBox(height: 300, child: _buildEmptyState())
                      : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return ProductCard(product: filteredProducts[index]);
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- MODERATE & PRO COMPONENTS ---

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
      child: SizedBox(
        height: 45,
        child: TextField(
          onChanged: (value) => setState(() => searchQuery = value),
          decoration: InputDecoration(
            hintText: "Search for vintage gems...",
            hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            prefixIcon: const Icon(Icons.search, size: 20, color: Colors.brown),
            fillColor: Colors.white,
            filled: true,
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryList() {
    return SizedBox(
      height: 38,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => selectedCategory = categories[index]),
              child: CategoryChip(
                label: categories[index],
                isSelected: selectedCategory == categories[index],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCartBadge() {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        IconButton(
          icon: const Icon(Icons.shopping_bag_outlined, size: 24, color: Colors.black87),
          onPressed: () {
            // Future Cart Navigation
          },
        ),
        Positioned(
          right: 6,
          top: 6,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: const BoxDecoration(color: Colors.brown, shape: BoxShape.circle),
            constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
            child: const Text(
              '2',
              style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off_outlined, size: 40, color: Colors.grey.shade300),
          const SizedBox(height: 12),
          Text(
            "We couldn't find '$searchQuery'",
            style: const TextStyle(color: Colors.grey, fontSize: 14),
          ),
          TextButton(
            onPressed: () => setState(() {
              searchQuery = "";
              selectedCategory = "All";
            }),
            child: const Text("View All Products", style: TextStyle(fontSize: 13, color: Colors.brown)),
          )
        ],
      ),
    );
  }
}
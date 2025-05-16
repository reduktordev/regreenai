import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:regreenai/data/produk_data.dart'; // Import data produk
import 'produk_detail.dart'; // Import halaman detail produk
import 'package:regreenai/componen/bottom_navigation.dart'; // Import komponen bottom navigation

class BuyForumPage extends StatefulWidget {
  const BuyForumPage({Key? key}) : super(key: key);

  @override
  _BuyForumPageState createState() => _BuyForumPageState();
}

class _BuyForumPageState extends State<BuyForumPage> {
  List<Map<String, dynamic>> _filteredProducts = List.from(products);
  String _searchQuery = '';

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredProducts = List.from(products);
      } else {
        _filteredProducts =
            products.where((product) {
              final name = product['name']?.toString().toLowerCase() ?? '';
              return name.contains(query.toLowerCase());
            }).toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forum Jual Beli')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Cari produk...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterProducts,
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  _filteredProducts.isEmpty
                      ? const Center(child: Text('Produk tidak ditemukan'))
                      : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 0.75,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                        itemCount: _filteredProducts.length,
                        itemBuilder: (context, index) {
                          final product = _filteredProducts[index];
                          return ProductCard(
                            product: product,
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => ProductDetailPage(
                                          name: product['name'],
                                          price: product['price'],
                                          stock: product['stock'],
                                          createdAt: product['created_at'],
                                          description: product['description'],
                                          image: product['image'],
                                        ),
                                  ),
                                ),
                          );
                        },
                      ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(currentIndex: 2),
    );
  }
}

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;
  final VoidCallback onTap;

  const ProductCard({Key? key, required this.product, required this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy');
    return InkWell(
      onTap: onTap,
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.asset(
                product['image'],
                height: 120,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['name'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text('Rp ${product['price'] ?? '-'}'),
                  const SizedBox(height: 4),
                  Text('Stok: ${product['stock'] ?? 0}'),
                  const SizedBox(height: 4),
                  if (product['created_at'] != null)
                    Text('Dibuat: ${dateFormat.format(product['created_at'])}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

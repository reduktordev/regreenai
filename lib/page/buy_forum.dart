import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:regreenai/componen/bottom_navigation.dart';
import 'package:regreenai/page/produk_detail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum Jual Beli',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const JualBeliPage(),
    );
  }
}

class JualBeliPage extends StatefulWidget {
  const JualBeliPage({super.key});

  // Daftar gambar produk
  static const List<String> productImages = [
    "assets/beras.jpg",
    "assets/jagung.jpeg",
    "assets/sayuran.jpg",
    "assets/buah.jpg",
    "assets/kedelai.jpg",
    "assets/tebu.jpeg",
  ];

  @override
  State<JualBeliPage> createState() => _JualBeliPageState();
}

class _JualBeliPageState extends State<JualBeliPage> {
  List<Map<String, dynamic>> _filteredProducts = List.from(_products);
  String _searchQuery = '';

  void _filterProducts(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredProducts = List.from(_products);
      } else {
        _filteredProducts =
            _products.where((product) {
              final name = product['name']?.toString().toLowerCase() ?? '';
              return name.contains(query.toLowerCase());
            }).toList();
      }
    });
  }

  // Widget icon tas + modern
  Widget modernShoppingBagPlusIcon() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Icon(Icons.shopping_bag_outlined, size: 30, color: Colors.green[700]),
        Positioned(
          right: -4,
          bottom: -4,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.green[700],
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(2),
            child: const Icon(Icons.add, size: 12, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            const SizedBox(height: 20),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 2;
                  if (constraints.maxWidth < 400) crossAxisCount = 1;
                  if (constraints.maxWidth > 800) crossAxisCount = 3;

                  return GridView.builder(
                    itemCount: _filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.95,
                    ),
                    itemBuilder: (context, index) {
                      final product = _filteredProducts[index];
                      return _buildProductCard(
                        context,
                        product['name'] ?? 'Nama produk kosong',
                        product['price'] ?? '-',
                        product['stock'],
                        product['created_at'],
                        product['description'],
                        product['image'],
                      );
                    },
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

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Forum Jual Beli',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Colors.green[900],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${_filteredProducts.length} Forum',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            Tooltip(
              message: 'Tambah produk baru',
              child: IconButton(
                onPressed: () {},
                icon: modernShoppingBagPlusIcon(),
                splashRadius: 24,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: TextField(
            onChanged: _filterProducts,
            decoration: InputDecoration(
              hintText: 'Cari produk atau diskusi...',
              prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 20,
              ),
              filled: true,
              fillColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    String name,
    String price,
    int? stock,
    DateTime? createdAt,
    String? description,
    String image,
  ) {
    return Material(
      elevation: 3,
      shadowColor: Colors.green.withOpacity(0.2),
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap:
            () => _showProductDetail(
              context,
              name,
              price,
              stock,
              createdAt,
              description,
              image,
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
              ),
              child: Image.asset(
                image,
                width: double.infinity,
                height: 140,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                      height: 1.2,
                    ),
                  ),
                  if (stock != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Stok: $stock',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  if (createdAt != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      'Dibuat: ${DateFormat('dd/MM/yyyy').format(createdAt)}',
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),
                  ],
                  const SizedBox(height: 10),
                  Text(
                    'Rp $price',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.remove_red_eye_outlined,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'LIHAT DETAIL',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[800],
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                      onPressed:
                          () => _showProductDetail(
                            context,
                            name,
                            price,
                            stock,
                            createdAt,
                            description,
                            image,
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showProductDetail(
    BuildContext context,
    String name,
    String price,
    int? stock,
    DateTime? createdAt,
    String? description,
    String image,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ProductDetailPage(
              name: name,
              price: price,
              stock: stock,
              createdAt: createdAt,
              description: description,
              image: image,
            ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _products = [
  {
    'name': 'Beras Organik Super',
    'price': '30.000',
    'stock': 15,
    'created_at': DateTime(2023, 4, 11),
    'description': 'Beras organik kualitas premium hasil panen terbaru',
    'image': JualBeliPage.productImages[0],
  },
  {
    'name': 'Jagung Manis Segar',
    'price': '15.000',
    'stock': 50,
    'created_at': DateTime(2023, 5, 2),
    'description': 'Jagung manis langsung dari kebun, masih segar',
    'image': JualBeliPage.productImages[1],
  },
  {
    'name': 'Sayuran Organik Mix',
    'price': '25.000',
    'stock': 30,
    'created_at': DateTime(2023, 3, 14),
    'description': 'Paket sayuran organik (kangkung, bayam, sawi)',
    'image': JualBeliPage.productImages[2],
  },
  {
    'name': 'Buah Naga Merah',
    'price': '45.000',
    'stock': 20,
    'created_at': DateTime(2023, 4, 20),
    'description': 'Buah naga merah segar hasil panen pagi',
    'image': JualBeliPage.productImages[3],
  },
  {
    'name': 'Kedelai Lokal',
    'price': '18.000',
    'stock': 100,
    'created_at': DateTime(2023, 2, 28),
    'description': 'Kedelai lokal kualitas ekspor',
    'image': JualBeliPage.productImages[4],
  },
  {
    'name': 'Tebu Manis',
    'price': '12.000',
    'stock': 80,
    'created_at': DateTime(2023, 5, 10),
    'description': 'Tebu segar langsung dari kebun',
    'image': JualBeliPage.productImages[5],
  },
];

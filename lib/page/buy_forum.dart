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

class JualBeliPage extends StatelessWidget {
  const JualBeliPage({super.key});

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
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: EdgeInsets.all(2), // dikurangi dari 4 ke 2
            child: Icon(
              Icons.add,
              size: 12, // dikurangi dari 16 ke 12
              color: Colors.white,
            ),
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
                    itemCount: _products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 0.95,
                    ),
                    itemBuilder: (context, index) {
                      final product = _products[index];
                      return _buildProductCard(
                        context,
                        product['name'] ?? 'Nama produk kosong',
                        product['price'] ?? '-',
                        product['stock'],
                        product['created_at'],
                        product['description'],
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
            // Judul dan subjudul
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
                  '200 Forum',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            // Ganti icon button dengan icon tas + modern
            Tooltip(
              message: 'Tambah produk baru',
              child: IconButton(
                onPressed: () {
                  // aksi tambah produk
                },
                icon: modernShoppingBagPlusIcon(),
                splashRadius: 24,
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // Search Bar
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
                'assets/padi.jpg',
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
            ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _products = [
  {
    'name': 'Padi Organik Super',
    'price': '30.000',
    'stock': 15,
    'created_at': DateTime(2023, 4, 11),
    'description':
        'Padi organik berkualitas tinggi dengan hasil panen melimpah.',
  },
  {
    'name': 'Beras Premium',
    'price': '45.000',
    'stock': 20,
    'created_at': DateTime(2023, 2, 28),
    'description': 'Beras premium, sangat cocok untuk keluarga Anda.',
  },
  {
    'name': 'Benih Padi Unggul',
    'price': '150.000',
    'stock': 50,
    'created_at': DateTime(2023, 5, 2),
    'description':
        'Benih padi unggul untuk hasil panen maksimal dan tahan penyakit.',
  },
  {
    'name': 'Pupuk Organik',
    'price': '25.000',
    'stock': 60,
    'created_at': DateTime(2023, 3, 14),
    'description': 'Pupuk organik ramah lingkungan untuk pertanian sehat.',
  },
  {
    'name': 'Alat Panen Padi',
    'price': '500.000',
    'stock': 7,
    'created_at': DateTime(2023, 4, 20),
    'description': 'Alat panen padi modern dan efisien.',
  },
];

import 'package:flutter/material.dart';
import 'package:regreenai/componen/bottom_navigation.dart';
import 'package:intl/intl.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F4), // Latar ala Facebook
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Forum Diskusi',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 10, // dummy
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// Header user
                  Row(
                    children: [
                      const CircleAvatar(
                        backgroundImage: AssetImage('assets/user.jpg'),
                        radius: 20,
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'User ${index + 1}',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat(
                              'dd MMM yyyy • hh:mm a',
                            ).format(DateTime.now()),
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  /// Gambar post
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      'assets/padi.jpg',
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// Konten teks
                  Text(
                    'Ini adalah isi dari postingan forum ke-${index + 1}. Ayo diskusi atau jual beli seputar pertanian!',
                    style: const TextStyle(fontSize: 15),
                  ),

                  const SizedBox(height: 8),

                  /// Tombol lihat detail
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Navigasi ke detail belum tersedia.'),
                          ),
                        );
                      },
                      child: const Text('Lihat Detail'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),

      /// Tombol tambah postingan
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fitur tambah postingan belum tersedia'),
            ),
          );
        },
        backgroundColor: Colors.green[800], // Hijau
        foregroundColor: Colors.white, // Teks dan ikon putih
        icon: const Icon(Icons.add),
        label: const Text(
          'Buat Postingan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      bottomNavigationBar: const CustomBottomNavigation(currentIndex: 3),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ForumDetailPage extends StatelessWidget {
  final String user;
  final DateTime dateTime;
  final String image;
  final String title;
  final String description;

  const ForumDetailPage({
    super.key,
    required this.user,
    required this.dateTime,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F4),
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Detail Postingan',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header user + waktu
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
                      user,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      DateFormat('dd MMM yyyy • hh:mm a').format(dateTime),
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Gambar postingan
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                image,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            // Judul postingan
            Text(
              title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Deskripsi
            Text(
              description,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}

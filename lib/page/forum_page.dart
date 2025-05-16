import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'forum_detail_page.dart';
import 'package:regreenai/componen/bottom_navigation.dart';
import 'package:regreenai/data/forum_data.dart'; // import data forum

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F3F4),
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
        itemCount: forumPosts.length,
        itemBuilder: (context, index) {
          final post = forumPosts[index];
          final dateTime = DateTime.parse(post['time']);
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => ForumDetailPage(
                        user: post['user'],
                        dateTime: dateTime,
                        image: post['image'],
                        title: post['title'],
                        description: post['description'],
                      ),
                ),
              );
            },
            child: Card(
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
                              post['user'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              DateFormat(
                                'dd MMM yyyy • hh:mm a',
                              ).format(dateTime),
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
                    // Gambar post
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        post['image'],
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      post['description'],
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Fitur tambah postingan belum tersedia'),
            ),
          );
        },
        backgroundColor: Colors.green[800],
        foregroundColor: Colors.white,
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

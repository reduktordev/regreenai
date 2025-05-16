import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Untuk format tanggal

// Model Comment
class Comment {
  final String username;
  final String userPhoto; // path ke asset image
  final String comment;
  final DateTime date;

  Comment({
    required this.username,
    required this.userPhoto,
    required this.comment,
    required this.date,
  });
}

class BlogDetailPage extends StatefulWidget {
  final String title;
  final String date;
  final String image;

  const BlogDetailPage({
    Key? key,
    required this.title,
    required this.date,
    required this.image,
  }) : super(key: key);

  @override
  State<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  final TextEditingController _commentController = TextEditingController();

  // Contoh data dummy komentar bertipe Comment
  final List<Comment> _comments = [
    Comment(
      username: 'Andi',
      userPhoto: 'assets/users/user.jpg',
      comment: 'Informasi yang sangat berguna!',
      date: DateTime.now().subtract(const Duration(hours: 2)),
    ),
    Comment(
      username: 'Budi',
      userPhoto: 'assets/users/user2.jpg',
      comment: 'Terima kasih sudah berbagi.',
      date: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
    ),
  ];

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        _comments.insert(
          0,
          Comment(
            username: 'User Baru', // Ganti dengan user sebenarnya jika ada
            userPhoto: 'assets/users/user3.jpg', // Foto default
            comment: text,
            date: DateTime.now(),
          ),
        );
      });
      _commentController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy, HH:mm').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title, style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF64D37A),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                widget.image,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              widget.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(widget.date, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 20),
            const Text(
              "Isi artikel atau deskripsi lengkapnya akan ditampilkan di sini...",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            const Text(
              'Komentar',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _comments.isEmpty
                ? const Text('Belum ada komentar.')
                : ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _comments.length,
                  separatorBuilder:
                      (context, index) => const Divider(height: 16),
                  itemBuilder: (context, index) {
                    final comment = _comments[index];
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage(comment.userPhoto),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    comment.username,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    _formatDate(comment.date),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                comment.comment,
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
            const SizedBox(height: 20),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                hintText: 'Tulis komentar...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFF64D37A)),
                  onPressed: _addComment,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              minLines: 1,
              maxLines: 3,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _addComment(),
            ),
          ],
        ),
      ),
    );
  }
}

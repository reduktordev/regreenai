import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chat_bubble_page.dart'; // Tambahkan import halaman chat jika ada

class ProductDetailPage extends StatefulWidget {
  final String name;
  final String price;
  final int? stock;
  final DateTime? createdAt;
  final String? description;
  final String image; // properti image wajib diisi

  const ProductDetailPage({
    Key? key,
    required this.name,
    required this.price,
    this.stock,
    this.createdAt,
    this.description,
    required this.image,
  }) : super(key: key);

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  final _commentController = TextEditingController();
  final List<String> _comments = [];
  bool _showAllComments = false;

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _submitComment() {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Komentar tidak boleh kosong')),
      );
      return;
    }
    setState(() {
      _comments.insert(0, comment);
      _commentController.clear();
      _showAllComments = false;
    });
    FocusScope.of(context).unfocus();
  }

  void _goToChat(String role) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ModernChatBubblePage(title: 'Chat $role'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        widget.createdAt != null
            ? DateFormat('dd MMM yyyy').format(widget.createdAt!)
            : '';

    final displayedComments =
        _showAllComments
            ? _comments
            : (_comments.length > 5 ? _comments.sublist(0, 5) : _comments);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 300,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: 'product-image-${widget.name}',
                child:
                    widget.image.startsWith('http')
                        ? Image.network(widget.image, fit: BoxFit.cover)
                        : Image.asset(widget.image, fit: BoxFit.cover),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Fitur share belum tersedia')),
                  );
                },
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Rp ${widget.price}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      if (widget.stock != null)
                        Chip(
                          label: Text(
                            'Stok: ${widget.stock}',
                            style: TextStyle(
                              color:
                                  widget.stock! > 0
                                      ? Colors.white
                                      : Colors.red[200],
                            ),
                          ),
                          backgroundColor:
                              widget.stock! > 0
                                  ? Colors.green
                                  : Colors.red[400],
                        ),
                      const Spacer(),
                      if (widget.createdAt != null)
                        Text(
                          'Dibuat: $formattedDate',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.description ?? 'Deskripsi produk belum tersedia.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.chat_bubble_outline,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Chat Penjual',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 6,
                            shadowColor: Colors.green.shade900.withOpacity(0.5),
                          ),
                          onPressed: () => _goToChat('Penjual'),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(
                            Icons.support_agent_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: const Text(
                            'Chat Admin',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 6,
                            shadowColor: Colors.green.shade900.withOpacity(0.8),
                          ),
                          onPressed: () => _goToChat('Admin'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Diskusi Produk',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.green.shade200),
                    ),
                    child: Column(
                      children: [
                        TextField(
                          controller: _commentController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Tulis komentar kamu di sini...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: _submitComment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Kirim Komentar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  if (_comments.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.green[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Belum ada komentar. Jadilah yang pertama memberi komentar tentang produk ini!',
                        style: TextStyle(
                          color: Colors.green[900]?.withOpacity(0.8),
                          fontStyle: FontStyle.italic,
                          fontSize: 16,
                        ),
                      ),
                    )
                  else
                    Column(
                      children: [
                        ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: displayedComments.length,
                          separatorBuilder:
                              (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.green[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                displayedComments[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.green[900],
                                ),
                              ),
                            );
                          },
                        ),
                        if (_comments.length > 5 && !_showAllComments)
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _showAllComments = true;
                              });
                            },
                            child: Text(
                              'Klik untuk selengkapnya',
                              style: TextStyle(color: Colors.green[800]),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

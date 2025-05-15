import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductDetailPage extends StatefulWidget {
  final String name;
  final String price;
  final int? stock;
  final DateTime? createdAt;
  final String? description;

  const ProductDetailPage({
    Key? key,
    required this.name,
    required this.price,
    this.stock,
    this.createdAt,
    this.description,
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Komentar tidak boleh kosong')));
      return;
    }
    setState(() {
      _comments.insert(0, comment);
      _commentController.clear();
      _showAllComments =
          false; // reset tampilan komentar lengkap setelah komentar baru
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate =
        widget.createdAt != null
            ? DateFormat('dd MMM yyyy').format(widget.createdAt!)
            : '';

    // Batasi komentar yang ditampilkan
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
                child: Image.asset('assets/padi.jpg', fit: BoxFit.cover),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.share, color: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Fitur share belum tersedia')),
                  );
                },
                tooltip: 'Bagikan Produk',
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

                  SizedBox(height: 8),

                  Text(
                    'Rp ${widget.price}',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.green[700],
                    ),
                  ),

                  SizedBox(height: 12),

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
                      Spacer(),
                      if (widget.createdAt != null)
                        Text(
                          'Dibuat: $formattedDate',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Deskripsi produk tanpa Card, font sederhana dan warna netral
                  Text(
                    widget.description ?? 'Deskripsi produk belum tersedia.',
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.grey[800],
                    ),
                  ),

                  SizedBox(height: 36),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.chat_bubble_outline,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Chat Penjual',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[600],
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 6,
                            shadowColor: Colors.green.shade900.withOpacity(0.5),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Chat dengan penjual belum tersedia.',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: Icon(
                            Icons.support_agent_outlined,
                            size: 20,
                            color: Colors.white,
                          ),
                          label: Text(
                            'Chat Admin',
                            style: TextStyle(color: Colors.white),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[900],
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            elevation: 6,
                            shadowColor: Colors.green.shade900.withOpacity(0.8),
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Chat dengan admin belum tersedia.',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 40),

                  Text(
                    'Diskusi Produk',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[900],
                    ),
                  ),
                  SizedBox(height: 12),

                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 12,
                            ),
                          ),
                        ),
                        SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            onPressed: _submitComment,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[600],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              elevation: 5,
                            ),
                            child: Text(
                              'Kirim Komentar',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24),

                  if (_comments.isEmpty)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16),
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: displayedComments.length,
                          separatorBuilder: (_, __) => SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return Container(
                              padding: EdgeInsets.all(14),
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

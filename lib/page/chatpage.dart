import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../service/gemini_service.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Color greenColor = const Color(0xFF64D37A);
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _imagePromptController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();

  // Removed duplicate _pickImage method to resolve the conflict.

  late final GeminiService gemini;
  XFile? _selectedImage;
  @override
  void initState() {
    super.initState();
    final apiKey = dotenv.env['GEMINI_API_KEY'] ?? '';
    gemini = GeminiService(apiKey);
  }

  List<Map<String, dynamic>> messages = [
    {
      "sender": "bot",
      "text": "Halo! Ada yang bisa ReGreen bantu? 😊",
      "isTyping": false,
    },
  ];

  final List<String> allowedTopics = [
    'tanam',
    'pertanian',
    'agrikultur',
    'cuaca',
    'hujan',
    'panas',
    'musim',
    'bisnis',
    'usaha',
    'pemasaran',
    'ekspor', // Tambahkan kata kunci baru
    'impor',
    'internasional',
    'logistik',
    'keuangan',
    'profit',
    'modal',
    'budidaya',
    'tumbuhan',
    'sayuran',
    'buah',
    'petani',
    'iklim',
    'komoditas',
    'pangan', // Kata kunci untuk hasil pangan
    'dagang',
    'pasar',
    'ekspor',
    'prosedur',
    'dokumen',
    'perizinan',
  ];

  final List<String> quickMessages = [
    'Bagaimana cara ekspor beras ke Singapura?',
    'Apa persyaratan ekspor hasil pertanian ke Eropa?',
    'Dokumen apa saja yang perlu dipersiapkan untuk ekspor?',
    'Bagaimana mengurus sertifikasi halal untuk ekspor?',
    'Berapa biaya logistik ekspor ke Timur Tengah?',
  ];

  bool showQuickMessages = true;

  bool isRelevantTopic(String text) {
    final lowerText = text.toLowerCase();
    return allowedTopics.any((topic) => lowerText.contains(topic)) ||
        lowerText.contains('cara') || // Menerima pertanyaan cara-cara
        lowerText.contains('bagaimana'); // Menerima pertanyaan metode
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _pickImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() => _selectedImage = image);
      _showImagePreview();
    }
  }

  void _showImagePreview() {
    if (_selectedImage == null) return;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Preview Gambar'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(
                    File(_selectedImage!.path),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ), // Perhatikan penempatan koma dan kurung
                TextField(
                  controller: _imagePromptController,
                  decoration: const InputDecoration(
                    hintText: 'Tambahkan pertanyaan...',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _selectedImage = null;
                  _imagePromptController.clear();
                },
                child: const Text('Batal'),
              ),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await sendMessage(_imagePromptController.text);
                  _imagePromptController.clear();
                },
                child: const Text('Kirim'),
              ),
            ],
          ),
    );
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty && _selectedImage == null) return;

    // Tambahkan pesan pengguna
    setState(() {
      messages.add({
        "sender": "user",
        "text": text.isNotEmpty ? text : "Analisis gambar ini",
        "image": _selectedImage?.path,
        "isTyping": false,
      });
      _controller.clear();
      showQuickMessages = false;
    });

    // Tambahkan typing indicator
    setState(
      () => messages.add({
        "sender": "bot",
        "text": "Mengetik...",
        "isTyping": true,
      }),
    );
    _scrollToBottom();

    try {
      final response = await _retryOnError(
        () => gemini.generateResponse(
          text.isNotEmpty
              ? text
              : "Apa yang bisa kamu jelaskan tentang gambar ini?",
          image: _selectedImage,
        ),
      );

      setState(() {
        messages.removeWhere((msg) => msg["isTyping"] == true);
        messages.add({
          "sender": "bot",
          "text": _formatResponse(response),
          "isTyping": false,
        });
      });
    } catch (e) {
      setState(() {
        messages.removeWhere((msg) => msg["isTyping"] == true);
        messages.add({
          "sender": "bot",
          "text": "⚠️ Error: ${e.toString().replaceAll('Exception: ', '')}",
          "isTyping": false,
        });
      });
    } finally {
      _selectedImage = null;
    }
    _scrollToBottom();
  }

  Future<T> _retryOnError<T>(Future<T> Function() fn, {int retries = 3}) async {
    for (var i = 0; i < retries; i++) {
      try {
        return await fn();
      } catch (e) {
        if (i == retries - 1) rethrow;
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    throw Exception('Max retries exceeded');
  }

  String _formatResponse(String text) {
    // Format response dengan emoji berdasarkan topik
    if (text.toLowerCase().contains('cuaca')) return '$text 🌦️';
    if (text.toLowerCase().contains('bisnis')) return '$text 💼';
    if (text.toLowerCase().contains('tanam')) return '$text 🌱';
    if (text.toLowerCase().contains('ekspor')) {
      return '📦 Ekspor Hasil Pangan 📜\n$text';
    }
    if (text.toLowerCase().contains('dokumen')) {
      return '📑 Dokumen yang diperlukan:\n$text';
    }
    return '$text 🌿';
  }

  // Update chatBubble untuk menampilkan gambar
  Widget chatBubble(Map<String, dynamic> message) {
    final isUser = message["sender"] == 'user';
    final isTyping = message["isTyping"] == true;
    final hasImage = message["image"] != null;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        constraints: const BoxConstraints(maxWidth: 280),
        decoration: BoxDecoration(
          color: isUser ? greenColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage)
              Container(
                height: 150,
                width: 200,
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: FileImage(File(message["image"])),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            isTyping
                ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(width: 8),
                    Text('Memproses...'),
                  ],
                )
                : Text(
                  message["text"],
                  style: TextStyle(
                    color: isUser ? Colors.white : Colors.black87,
                    fontSize: 14,
                  ),
                ),
          ],
        ),
      ),
    );
  }

  Widget quickMessagesBox() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child:
          showQuickMessages
              ? Container(
                key: const ValueKey(true),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Tanya Cepat",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.keyboard_arrow_up),
                          onPressed:
                              () => setState(() => showQuickMessages = false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ...quickMessages.map(
                      (msg) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.chat_bubble_outline,
                          size: 20,
                        ),
                        title: Text(msg, style: const TextStyle(fontSize: 14)),
                        onTap: () => sendMessage(msg),
                      ),
                    ),
                  ],
                ),
              )
              : Container(
                key: const ValueKey(false),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text(
                        "Tanya Cepat",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.keyboard_arrow_down),
                      onPressed: () => setState(() => showQuickMessages = true),
                    ),
                  ],
                ),
              ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "ReGreen Chat",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              itemCount: messages.length,
              itemBuilder: (context, index) => chatBubble(messages[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Row(
              children: [
                IconButton(
                  icon: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.grey),
                      ),
                      if (_selectedImage != null)
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              color: Colors.green,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.check,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                    ],
                  ),
                  onPressed: _pickImage,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Tanya ReGreen. . .',
                        border: InputBorder.none,
                      ),
                      onSubmitted: sendMessage,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    color: greenColor,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.send, color: Colors.white),
                    onPressed: () => sendMessage(_controller.text),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final Color greenColor = const Color(0xFF64D37A);
  final TextEditingController _controller = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {"sender": "bot", "text": "Halo! Ada yang bisa ReGreen bantu? 😊"},
  ];

  final List<String> quickMessages = [
    "Apa Yang Cocok Ditanam di Musim Ini?",
    "Sayuran Musim Dingin yang Populer",
    "Tumbuhan Hias yang Tahan Dingin",
    "Makanan yang Bisa Ditanam di Kebun Mini",
    "Tips Perawatan Tanaman di Musim Dingin",
  ];

  bool showQuickMessages = true;

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      messages.add({"sender": "user", "text": text});
      _controller.clear();
      showQuickMessages = false;

      // Simulasi respon bot
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          messages.add({
            "sender": "bot",
            "text": "ReGreen sedang mencari jawaban terbaik untuk:\n\"$text\" 🌱"
          });
        });
      });
    });
  }

  Widget chatBubble(String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? greenColor : Colors.grey.shade200,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isUser ? Colors.white : Colors.black87,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget quickMessagesBox() {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: showQuickMessages
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
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.keyboard_arrow_up),
                        onPressed: () => setState(() => showQuickMessages = false),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ...quickMessages.map(
                    (msg) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.chat_bubble_outline, size: 20),
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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Expanded(
                    child: Text("Tanya Cepat", style: TextStyle(fontWeight: FontWeight.bold)),
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
    final isFirstTime = messages.length <= 1;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("ReGreen Chat", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              children: [
                ...messages.map((msg) => chatBubble(msg['text'], msg['sender'] == 'user')),
                const SizedBox(height: 16),
                if (isFirstTime || showQuickMessages) quickMessagesBox(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.grey),
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

import 'package:flutter/material.dart';
import 'package:regreenai/homepage.dart';

class ModernChatBubblePage extends StatelessWidget {
  const ModernChatBubblePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chatList = [
      {
        'name': 'John Doe',
        'message': 'Hey, how’s the harvest?',
        'time': '10:24 AM',
        'avatar': 'assets/users/user.jpg',
        'unread': 2,
        'isOnline': true,
      },
      {
        'name': 'Maria Farmer',
        'message': 'We need to discuss fertilizer supply.',
        'time': '09:50 AM',
        'avatar': 'assets/users/user2.jpg',
        'unread': 0,
        'isOnline': false,
      },
      {
        'name': 'Andi Tani',
        'message': 'Bisa bantu tanam padi minggu depan?',
        'time': 'Yesterday',
        'avatar': 'assets/users/user3.jpg',
        'unread': 3,
        'isOnline': true,
      },
      {
        'name': 'Siti Hidayah',
        'message': 'Sudah saya kirim laporan panen.',
        'time': 'Monday',
        'avatar': 'assets/users/user4.jpg',
        'unread': 0,
        'isOnline': false,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.green),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
              (route) => false,
            );
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.green),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemCount: chatList.length,
        separatorBuilder: (context, index) => const Divider(height: 0),
        itemBuilder: (context, index) {
          final chat = chatList[index];
          return Container(
            color: Colors.white,
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                chat['isOnline']
                                    ? Colors.green
                                    : Colors.transparent,
                          ),
                          child: CircleAvatar(
                            radius: 28,
                            backgroundImage: AssetImage(chat['avatar']),
                          ),
                        ),
                        if (chat['isOnline'])
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                chat['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              const Spacer(),
                              Text(
                                chat['time'],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            chat['message'],
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (chat['unread'] > 0)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: const BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          chat['unread'].toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ModernChatBubblePage(),
    ),
  );
}

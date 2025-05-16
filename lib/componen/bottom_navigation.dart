// File: components/bottom_navigation.dart
import 'package:flutter/material.dart';
import 'package:regreenai/homepage.dart' as home;
import 'package:regreenai/page/chat_bubble_page.dart';
import 'package:regreenai/page/profile.dart';
import 'package:regreenai/page/buy_forum.dart';
import 'package:regreenai/page/forum_page.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavigation({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        if (index == currentIndex) return;

        switch (index) {
          case 0:
            _navigateToScreen(context, const home.HomePage());
            break;
          case 1:
            _navigateToScreen(
              context,
              const ModernChatBubblePage(title: 'Chat List'),
            );
            break;
          case 2:
            _navigateToScreen(context, const BuyForumPage());
            break;
          case 3:
            _navigateToScreen(context, const ForumPage());
            break;
          case 4:
            _navigateToScreen(context, const ProfilePage());
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Beranda',
        ), // index 0
        BottomNavigationBarItem(
          icon: Icon(Icons.forum),
          label: 'Chat',
        ), // index 1
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_basket),
          label: 'Jual Beli',
        ), // index 2
        BottomNavigationBarItem(
          icon: Icon(Icons.receipt),
          label: 'Forum',
        ), // index 3
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profil',
        ), // index 4
      ],
    );
  }

  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => screen),
      (route) => false,
    );
  }
}

class EmptyPage extends StatelessWidget {
  final String title;

  const EmptyPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Center(
        child: Text(
          'Halaman ini masih dalam pengembangan.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:regreenai/page/chatpage.dart';
import 'package:regreenai/componen/bottom_navigation.dart';
import 'package:regreenai/data/forum_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final Color greenColor = const Color(0xFF64D37A);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, String>> blogList = [
    {
      "title": "Cara Menanam Sayuran di Pekarangan",
      "date": "16 Mei 2025",
      "image": "assets/blog1.jpg",
    },
    {
      "title": "Strategi Ekspor Pangan Lokal",
      "date": "12 Mei 2025",
      "image": "assets/blog2.jpg",
    },
    {
      "title": "Pupuk Organik: Tips dan Trik",
      "date": "10 Mei 2025",
      "image": "assets/blog3.jpg",
    },
    {
      "title": "Hidroponik untuk Pemula",
      "date": "08 Mei 2025",
      "image": "assets/blog4.jpg",
    },
    {
      "title": "Sistem Irigasi Pintar di Lahan Kering",
      "date": "05 Mei 2025",
      "image": "assets/blog5.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChatPage()),
          );
        },
        backgroundColor: greenColor,
        foregroundColor: Colors.white,
        shape: const CircleBorder(),
        child: Image.asset('assets/logo/chatlogo.png', width: 24, height: 24),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBanner(),
              const SizedBox(height: 16),
              const Text(
                'Excited To Farm, Manage, And Grow Smarter?',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              _buildSearchBar(),
              const SizedBox(height: 24),
              _sectionHeader(const Icon(Icons.newspaper), 'News & Blog'),
              const SizedBox(height: 20),
              _blogHorizontalList(),
              const SizedBox(height: 16),
              _separatorImage(),
              const SizedBox(height: 16),
              _sectionHeader(
                const Icon(Icons.local_fire_department),
                'Hot Topics',
              ),
              const SizedBox(height: 20),
              _forumHorizontalList(),
              const SizedBox(height: 16),
              _sectionHeader(const Icon(Icons.auto_graph), 'Top Sales'),
              const SizedBox(height: 12),
              _topSalesGrid(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigation(currentIndex: 0),
    );
  }

  Widget _buildBanner() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        children: [
          Image.asset(
            'assets/banner.png',
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 35,
            right: 100,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'From Seed To Harvest, Manage\nIt All In One Smart Platform',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Track, plan, and optimize every farming\noperation in one platform.',
                    style: TextStyle(fontSize: 10, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search',
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.green.shade400),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.green.shade700, width: 2),
        ),
        suffixIcon: const Icon(Icons.search, color: Colors.green),
      ),
    );
  }

  Widget _sectionHeader(Icon icon, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text('Explore →', style: TextStyle(color: greenColor)),
      ],
    );
  }

  Widget _blogHorizontalList() {
    return SizedBox(
      height: 160,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: blogList.length,
        itemBuilder: (context, index) {
          final blog = blogList[index];
          return Container(
            width: 140,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    blog["image"]!,
                    height: 80,
                    width: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  blog["title"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  blog["date"]!,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _forumHorizontalList() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: forumPosts.length,
        itemBuilder: (context, index) {
          final item = forumPosts[index];
          return Container(
            width: 200,
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.grey.shade100,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    item["image"]!,
                    width: 200,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    item["title"]!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    item["time"]!,
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _topSalesGrid() {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: List.generate(4, (index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                height: 150,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              Container(
                color: Colors.black.withOpacity(0.4),
                padding: const EdgeInsets.all(8),
                child: const Text(
                  'Smart Crop\nEfficient and Profitable',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _separatorImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            Image.asset(
              'assets/separator.png',
              width: double.infinity,
              height: 140,
              fit: BoxFit.cover,
            ),
            Container(
              height: 140,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black54, Colors.transparent],
                ),
              ),
            ),
            const Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Text(
                'Rice Feeds Half the Planet\nBut Only 6 Countries Produce 75%!\nChina, India, & Indonesia lead the global rice trade.',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

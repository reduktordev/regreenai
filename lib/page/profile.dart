import 'package:flutter/material.dart';
import 'package:regreenai/componen/bottom_navigation.dart'; // Ganti dengan navigasi bawah milikmu

void main() {
  runApp(const MaterialApp(home: ProfilePage()));
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int selectedTab = 0; // 0 = Tanya Jawab, 1 = Jual Beli

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Stack(
                clipBehavior: Clip.none,
                children: [
                  // Banner (nanti ganti warna dengan gambar banner)
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      // nanti ganti jadi image:
                      // image: DecorationImage(
                      //   image: AssetImage('assets/banner.jpg'),
                      //   fit: BoxFit.cover,
                      // ),
                    ),
                  ),
                  // Profil foto + teks, center horizontal dengan Positioned left/right 0 + Center widget
                  Positioned(
                    top:
                        120, // posisi top, sesuaikan supaya profil muncul sebagian dari banner
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 55,
                            backgroundImage: AssetImage('assets/user.jpg'),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Joko Wee',
                            style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '100K Followers',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                '  •  ',
                                style: TextStyle(color: Colors.grey),
                              ),
                              Text(
                                '100 Following',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
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
              SizedBox(
                height: 130,
              ), // memberi jarak agar konten bawah tidak tertumpuk
              // BIO
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Bio',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.flag, size: 18, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Indonesia'),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.cake, size: 18, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Usia: 42'),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on, size: 18, color: Colors.grey),
                        SizedBox(width: 8),
                        Text('Bogor'),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.info_outline, size: 18, color: Colors.grey),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Petani berpengalaman yang senang berbagi dan berdiskusi soal pertanian.',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // TOMBOL AKSI
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[400],
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {},
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.green[400]!),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Share Profile',
                          style: TextStyle(
                            color: Colors.green[400],
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),

              // TAB MENU
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedTab = 0),
                        child: Column(
                          children: [
                            Text(
                              'Forum Tanya Jawab',
                              style: TextStyle(
                                fontWeight:
                                    selectedTab == 0
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                fontSize: 16,
                                color:
                                    selectedTab == 0
                                        ? Colors.black
                                        : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (selectedTab == 0)
                              Container(
                                height: 3,
                                width: double.infinity,
                                color: Colors.black,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 25),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => selectedTab = 1),
                        child: Column(
                          children: [
                            Text(
                              'Forum Jual Beli',
                              style: TextStyle(
                                fontWeight:
                                    selectedTab == 1
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                fontSize: 16,
                                color:
                                    selectedTab == 1
                                        ? Colors.black
                                        : Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 10),
                            if (selectedTab == 1)
                              Container(
                                height: 3,
                                width: double.infinity,
                                color: Colors.black,
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // KONTEN
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child:
                    selectedTab == 0
                        ? _buildForumTanyaJawab()
                        : _buildForumJualBeli(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigation(currentIndex: 4),
    );
  }

  Widget _buildForumTanyaJawab() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        ForumQA(
          question:
              'Bagaimana cara mengatasi daun cabai yang menguning dan menggulung?',
          questionDescription: 'Tanaman cabai saya berusia sekitar 1 bulan...',
          tags: ['Cabai', 'nutrisi-tanaman', 'pupuk'],
          author: 'DaniPetani23',
          time: '1 menit lalu',
          questionStats: '2 suara | 1 jawaban | 5 tayangan',
        ),
        SizedBox(height: 25),
        ForumQA(
          question:
              'Apa penyebab daun tomat berkerut dan bagaimana cara mengatasinya?',
          questionDescription: 'Daun tomat saya terlihat berkerut...',
          tags: ['Tomat', 'penyakit-tanaman', 'perawatan'],
          author: 'DaniPetani23',
          time: '2 jam lalu',
          questionStats: '0 suara | 0 jawaban | 3 tayangan',
        ),
      ],
    );
  }

  Widget _buildForumJualBeli() {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        _buildJualItem(
          imagePath: 'assets/padi.jpg',
          title: 'Jual Bibit Padi Ciherang Super',
          tag: 'Bibit & Benih',
          time: '1 menit lalu',
        ),
        const SizedBox(height: 15),
        _buildJualItem(
          imagePath: 'assets/padi.jpg',
          title: 'Jual Tanaman Hias Monstera',
          tag: 'Tanaman Hias',
          time: '5 menit lalu',
        ),
        const SizedBox(height: 15),
        _buildJualItem(
          imagePath: 'assets/padi.jpg',
          title: 'Jual Benih Sayur Bayam',
          tag: 'Sayuran Organik',
          time: '10 menit lalu',
        ),
      ],
    );
  }

  Widget _buildJualItem({
    required String imagePath,
    required String title,
    required String tag,
    required String time,
  }) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(
            imagePath,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(tag, style: const TextStyle(fontSize: 12)),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                time,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ForumQA extends StatelessWidget {
  final String question;
  final String questionDescription;
  final List<String> tags;
  final String author;
  final String time;
  final String questionStats;

  const ForumQA({
    super.key,
    required this.question,
    required this.questionDescription,
    required this.tags,
    required this.author,
    required this.time,
    required this.questionStats,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Text(questionDescription, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children:
              tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(tag, style: const TextStyle(fontSize: 13)),
                    ),
                  )
                  .toList(),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const CircleAvatar(
              radius: 12,
              backgroundColor: Colors.grey,
              child: Icon(Icons.person, size: 16, color: Colors.white),
            ),
            const SizedBox(width: 8),
            Text(author, style: const TextStyle(fontSize: 13)),
            const Spacer(),
            Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
        if (questionStats.isNotEmpty) ...[
          const SizedBox(height: 6),
          Text(
            questionStats,
            style: const TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ],
    );
  }
}

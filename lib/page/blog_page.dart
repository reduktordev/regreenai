import 'package:flutter/material.dart';
import '../data/blog_data.dart';
import 'blog_detail_page.dart';

class BlogPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Blog')),
      body: ListView.builder(
        itemCount: blogList.length,
        itemBuilder: (context, index) {
          final blog = blogList[index];
          return ListTile(
            leading: Image.asset(blog["image"]!, width: 100, fit: BoxFit.cover),
            title: Text(blog['title']!),
            subtitle: Text(blog['date']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => BlogDetailPage(
                        title: blog['title']!,
                        date: blog['date']!,
                        image: blog['image']!,
                      ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

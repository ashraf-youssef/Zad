import 'package:flutter/material.dart';
import 'package:zad/BookListPage.dart';

class HomePage extends StatelessWidget {
  final List<String> levels = [
    "الفصل الدراسي 1",
    "الفصل الدراسي 2",
    "الفصل الدراسي 3",
    "الفصل الدراسي 4"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('الفصول الدراسية')),
      body: ListView.builder(
        itemCount: levels.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(levels[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => BookListPage(level: levels[index])),
              );
            },
          );
        },
      ),
    );
  }
}

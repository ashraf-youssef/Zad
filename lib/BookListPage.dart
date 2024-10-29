import 'package:flutter/material.dart';
import 'package:zad/PDFViewerPage.dart';

class BookListPage extends StatelessWidget {
  final String level;
  final List<String> books = [
    "كتاب 1",
    "كتاب 2",
    "كتاب 3",
    "كتاب 4",
    "كتاب 5",
    "كتاب 6",
    "كتاب 7"
  ];

  BookListPage({required this.level});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(level)),
      body: ListView.builder(
        itemCount: books.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(books[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PDFViewerPage(
                      bookTitle: books[index], bookPath: 'path_to_pdf'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

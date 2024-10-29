import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PDFViewerPage extends StatefulWidget {
  final String bookTitle;
  final String bookPath;

  PDFViewerPage({required this.bookTitle, required this.bookPath});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  int _currentPage = 0;
  int? _totalPages;
  late PDFViewController _pdfViewController;
  late SharedPreferences _prefs;

  @override
  void initState() {
    super.initState();
    _loadLastPage();
  }

  _loadLastPage() async {
    _prefs = await SharedPreferences.getInstance();
    int? savedPage = _prefs.getInt('${widget.bookTitle}_lastPage');
    if (savedPage != null) {
      setState(() {
        _currentPage = savedPage;
      });
    }
  }

  _saveLastPage(int page) async {
    await _prefs.setInt('${widget.bookTitle}_lastPage', page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.bookTitle)),
      body: PDFView(
        filePath: widget.bookPath,
        defaultPage: _currentPage,
        onRender: (pages) {
          setState(() {
            _totalPages = pages;
          });
        },
        onViewCreated: (PDFViewController vc) {
          _pdfViewController = vc;
        },
        onPageChanged: (page, total) {
          setState(() {
            _currentPage = page!;
          });
          _saveLastPage(_currentPage);
        },
      ),
    );
  }
}

/*

لحفظ العلامات المرجعية (Bookmarks)، يمكن استخدام SharedPreferences بنفس الطريقة التي تم بها حفظ الصفحة الأخيرة. يمكنك تخزين قائمة بالصفحات المرجعية داخل نفس المتغيرات المخصصة لكل كتاب.

يمكنك عرض العلامات المرجعية (Bookmarks) في صفحة قائمة بجميع العلامات وحين الضغط عليها يعود المستخدم مباشرة إلى الصفحة المحفوظة.


_saveBookmark(int page) async {
  List<String> bookmarks = _prefs.getStringList('${widget.bookTitle}_bookmarks') ?? [];
  if (!bookmarks.contains(page.toString())) {
    bookmarks.add(page.toString());
    await _prefs.setStringList('${widget.bookTitle}_bookmarks', bookmarks);
  }
}

_loadBookmarks() async {
  List<String> bookmarks = _prefs.getStringList('${widget.bookTitle}_bookmarks') ?? [];
  return bookmarks.map((page) => int.parse(page)).toList();
}


*/
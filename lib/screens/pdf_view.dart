import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class PDFViewerCachedFromUrl extends StatefulWidget {
  PDFViewerCachedFromUrl({Key key}) : super(key: key);
  static const routeName = '/pdf_view.dart';

  @override
  PDFViewerCachedFromUrlState createState() => PDFViewerCachedFromUrlState();
}

class PDFViewerCachedFromUrlState extends State<PDFViewerCachedFromUrl> {
  int _totalPages = 0;
  int _currentPage = 0;

  PDFViewController _pdfViewerController;
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as List;
    final url = arguments[0];
    final pdfName = arguments[1];
    return Scaffold(
      appBar: AppBar(
        title: Text(pdfName),
      ),
      body: PDF(
        swipeHorizontal: true,
        onRender: (pages) {
          setState(() {
            _totalPages = pages;
          });
        },
        onViewCreated: (PDFViewController vc) {
          _pdfViewerController = vc;
        },
        onPageChanged: (page, total) {
          setState(() {
            _currentPage = page;
          });
        },
      ).cachedFromUrl(
        url,
        placeholder: (double progress) => Center(child: Text('$progress %')),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _currentPage > 0
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.red,
                  label: Text("Go to ${_currentPage - 1}"),
                  onPressed: () async {
                    _currentPage -= 1;
                    await _pdfViewerController.setPage(_currentPage);
                  },
                )
              : Offstage(),
          _currentPage < _totalPages
              ? FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  label: Text("Go to ${_currentPage + 1}"),
                  onPressed: () async {
                    _currentPage += 1;
                    await _pdfViewerController.setPage(_currentPage);
                  },
                )
              : Offstage(),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:pdf_viewer/screens/file_grid.dart';
import 'package:pdf_viewer/screens/pdf_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
       home: FileGridView(),
     // home: PDFViewerCachedFromUrl(),
      routes: {
        PDFViewerCachedFromUrl.routeName: (context) => PDFViewerCachedFromUrl()
      },
    );
  }
}

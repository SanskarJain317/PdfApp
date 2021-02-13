import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pdf_viewer/widgets/grid_struct.dart';

class FileGridView extends StatefulWidget {
  @override
  _FileGridViewState createState() => _FileGridViewState();
}

class _FileGridViewState extends State<FileGridView> {
  @override
  void initState() {
    super.initState();
  }

  // var _isInit = true;

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('flutter_cached_pdfview Demo'),
        ),
        body: PdfGrid());
  }
}

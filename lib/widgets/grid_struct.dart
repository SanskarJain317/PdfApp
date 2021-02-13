import 'package:flutter/material.dart';
import 'package:pdf_viewer/provider/pdf_url_provider.dart';
import 'package:pdf_viewer/widgets/thumd_nail.dart';

class PdfGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdfUrls = PdfUrlProvider().items;
    final pdfNames = PdfUrlProvider().pdfName;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: pdfUrls.length,
      itemBuilder: (context, index) =>
          ThumbNail(pdfUrl: pdfUrls[index], pdfname: pdfNames[index]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:pdf_viewer/screens/pdf_view.dart';

class ThumbNail extends StatelessWidget {
  final String pdfUrl;
  final String pdfname;
  ThumbNail({this.pdfUrl, this.pdfname});
  //PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    print(pdfname);
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        border: Border.all(color: Colors.black54),
      ),
      child: GridTile(
          child: Stack(children: <Widget>[
            PDF(
              enableSwipe: false,
              swipeHorizontal: false,
              fitPolicy: FitPolicy.BOTH,
            ).cachedFromUrl(
              pdfUrl,
              placeholder: (double progress) =>
                  Center(child: CircularProgressIndicator()),
              errorWidget: (dynamic error) =>
                  Center(child: Text(error.toString())),
            ),
            Opacity(
              opacity: 1.0,
              child: Expanded(child: Container(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(
                        PDFViewerCachedFromUrl.routeName,
                        arguments: [pdfUrl, pdfname]);
                  },
                ),
              )),
            ),
          ]),
          footer: GridTileBar(
              leading: Container(),
              title: Container(
                child: Text(
                  pdfname,
                  textAlign: TextAlign.center,
                ),
                color: Colors.red,
              ))),
    );
  }
}

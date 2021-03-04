import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
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
  double _sliderValue = 1;
  PDFViewController _pdfViewerController;
  ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context).settings.arguments as List;
    final url = arguments[0];
    final pdfName = arguments[1];
    return OrientationBuilder(
      builder: (context, orientation) {
        return Scaffold(
            appBar: orientation == Orientation.portrait
                ? AppBar(
                    title: Text(pdfName),
                  )
                : null,
            body: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height * 0.9
                      : MediaQuery.of(context).size.height,
                  child: Center(
                    child: PDF(
                      autoSpacing: false,
                      pageFling: true,
                      fitPolicy: orientation == Orientation.portrait
                          ? FitPolicy.BOTH
                          : FitPolicy.HEIGHT,
                      onPageChanged: (int page, int total) {
                        // print('page change: $page/$total');
                        if (_totalPages == 0)
                          setState(() {
                            _totalPages = total;
                          });

                        setState(() {
                          _currentPage = page;
                          _sliderValue = page.toDouble();
                        });
                      },
                      onViewCreated: (PDFViewController pdfController) async {
                        setState(() {
                          _pdfViewerController = pdfController;
                        });
                      },
                    ).cachedFromUrl(
                      url,
                      placeholder: (double progress) =>
                          Center(child: Text('$progress %')),
                      errorWidget: (dynamic error) =>
                          Center(child: Text(error.toString())),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    width: 20,
                    height: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height * 0.87
                        : MediaQuery.of(context).size.height * 0.78,
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Slider(
                        label: '$_sliderValue',
                        value: _sliderValue == 1
                            ? _currentPage.toDouble()
                            : _sliderValue,
                        min: 0,
                        max: _totalPages > 0
                            ? _totalPages.toDouble() - 1
                            : _totalPages.toDouble(),
                        onChanged: (value) async {
                          setState(() {
                            _sliderValue = value;
                          });

                          print(MediaQuery.of(context).size.height);
                          if (value == 0) {
                            await _pdfViewerController.setPage(0);
                          }
                          if (value.toInt() > _currentPage.toInt()) {
                            await _pdfViewerController.setPage(value.toInt());
                            _currentPage = value.toInt();
                          }
                          if (value.toInt() + 1 < _currentPage.toInt() &&
                              (value + 0.5).toInt() > 0) {
                            await _pdfViewerController
                                .setPage(value.toInt() + 1);
                            _currentPage = value.toInt() + 1;
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
    // Container(child: SfPdfViewer.network(url)));
  }
}

class PdfUrlProvider {
  List _pdfname = ["Sample Pdf 1", "Sample Pdf 2", "Sample Pdf 3"];
  List _item = [
    "https://www.escaux.com/rsrc/EscauxCustomerDocs/DRD_T38Support_AdminGuide/T38_TEST_PAGES.pdf",
    "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf",
    "http://www.pdf995.com/samples/pdf.pdf"
  ];
  PdfUrlProvider();

  List get pdfName {
    return [..._pdfname];
  }

  List get items {
    return [..._item];
  }
}

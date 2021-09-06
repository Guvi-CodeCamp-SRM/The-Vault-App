import 'dart:convert';
import 'package:image/image.dart' as Im;
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

class PageI extends StatefulWidget {
  var bytes;
  String name;
  var pdf;
  PageI({this.bytes, @required this.name, this.pdf});

  @override
  _PageIState createState() => _PageIState();
}

class _PageIState extends State<PageI> {
  Future<Widget> pdfViewer(dynamic doc) async {
    //   // Im.Image i = Im.decodeImage(bytes);
    //   // final img = pw.MemoryImage(base64.decode(widget.bytes));
    //   // final pdf = pw.Document();
    //   // pdf.addPage(pw.Page(build: (pw.Context context) {
    //   //   return pw.Center(
    //   //     child: pw.Image(img),
    //   //   ); // Center
    //   // }));

    //   print("object");
    //   // return PdfViewer.openData(
    //   //   doc,
    //   //   params: PdfViewerParams(pageNumber: 1),
    //   );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (widget.name != "pdf")
          ? Image.memory(base64.decode(widget.bytes))
          : null,
    );
  }
}

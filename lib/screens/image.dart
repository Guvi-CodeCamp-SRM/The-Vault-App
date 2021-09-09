import 'dart:convert';
import 'dart:io';
// import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
// import 'package:image/image.dart' as Im;
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
//import 'package:pdf/pdf.dart';
// import 'dart:io';
import 'package:pdf/widgets.dart' as pw;

// ignore: must_be_immutable
class PageI extends StatefulWidget {
  var bytes;
  String name;
  String pdfPath;
  PageI({this.bytes, @required this.name, this.pdfPath});

  @override
  _PageIState createState() => _PageIState();
}

class _PageIState extends State<PageI> {
  Future<void> pdfView() async {
    final pdf = pw.Document();
    final im = pw.MemoryImage(File(widget.pdfPath).readAsBytesSync());
    pdf.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Image(im),
      ); // Center
    }));

    // final file = File('example.pdf');
    // await file.writeAsBytes(await pdf.save());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (widget.name != "pdf")
          ? Image.memory(base64.decode(widget.bytes))
          : PDFView(filePath: widget.pdfPath),
    );
  }
}

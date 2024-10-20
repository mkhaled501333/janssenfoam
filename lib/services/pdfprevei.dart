import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PDfpreview extends StatelessWidget {
  const PDfpreview({super.key, required this.v});
  final FutureOr<Uint8List> v;
  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
          return Scaffold(
            
        body: PdfPreview(build: (d) => v),
      );
    } else {
      return Scaffold(
        appBar: AppBar(),
        body: PdfPreview(build: (d) => v),
      );
    }
    
  }
}

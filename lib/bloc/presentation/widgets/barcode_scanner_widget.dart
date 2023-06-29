import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class MobileQRScanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MobileScanner(
          // fit: BoxFit.contain,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            final Uint8List? image = capture.image;
            for (final barcode in barcodes) {
              debugPrint('Barcode found! ${barcode.rawValue}');
            }
          },
        ),
      ],
    );
  }

}


import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qrapp/providers/scan_list_provider.dart';
import 'package:qrapp/src/utils/utils.dart';

class ScannButton extends StatelessWidget {
  const ScannButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 0,
      onPressed: () async {
        String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#3d8bef',
          'Cancelar',
          false,
          ScanMode.QR,
        ); 
       /*  const barcodeScanRes = 'geo:40.730610,-73.935242'; */
        if (barcodeScanRes == '-1') {
          return;
        }

        final scanListProvider =
            Provider.of<ScanListProvider>(context, listen: false);
        final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);
        launchURL(context, nuevoScan);

        /*  print(barcodeScanRes); */
      },
      child: const Icon(Icons.filter_center_focus),
    );
  }
}

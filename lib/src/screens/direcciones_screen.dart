import 'package:flutter/material.dart';
import 'package:qrapp/src/widgets/scan_tiles.dart';

class DireccionesScreen extends StatelessWidget {
  const DireccionesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'http');
  }
}

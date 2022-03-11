import 'package:flutter/material.dart';
import 'package:qrapp/src/widgets/scan_tiles.dart';

class MapasScreen extends StatelessWidget {
  const MapasScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScanTiles(tipo: 'geo');
  }
}

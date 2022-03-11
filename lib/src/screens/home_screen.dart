import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrapp/providers/scan_list_provider.dart';

import 'package:qrapp/providers/ui_provider.dart';
import 'package:qrapp/src/screens/direcciones_screen.dart';
import 'package:qrapp/src/screens/mapas_screen.dart';
import 'package:qrapp/src/widgets/custom_navigatorbar.dart';
import 'package:qrapp/src/widgets/scann_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial'),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                final scanListProvider =
                    Provider.of<ScanListProvider>(context, listen: false);
                scanListProvider.borrarTodos();
              },
              icon: const Icon(
                Icons.delete_forever_outlined,
              ))
        ],
      ),
      body: const _HomePageBody(),
      bottomNavigationBar: const CustomNavigatorBar(),
      floatingActionButton: const ScannButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HomePageBody extends StatelessWidget {
  const _HomePageBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    // Cambiar para mostrar la pagina respectiva
    final currentIndex = uiProvider.selectMenuOpt;
    //Temporal leer la base de datos

    /*  final tempScan = ScanModel(valor: 'https://www.google.com');
    DBProvider.db.nuevoScan(tempScan); */
    //Usar el ScanList Provider
    final scanListProvider =
        Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex) {
      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return const MapasScreen();
      case 1:
        scanListProvider.cargarScanPorTipo('http');
        return const DireccionesScreen();
      default:
        return const MapasScreen();
    }
  }
}

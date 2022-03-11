import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrapp/providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Obtener el selected menu opt
    final uiProvider = Provider.of<UiProvider>(context);
    final currenIndex = uiProvider.selectMenuOpt;
    return BottomNavigationBar(
      onTap: (int i) {
        uiProvider.selectMenuOpt = i;
      },
      elevation: 0,
      currentIndex: currenIndex,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.compass_calibration),
          label: 'Direcciones',
        ),
      ],
    );
  }
}

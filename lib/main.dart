import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qrapp/providers/scan_list_provider.dart';
import 'package:qrapp/providers/ui_provider.dart';
import 'package:qrapp/src/screens/home_screen.dart';
import 'package:qrapp/src/screens/mapa_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => ScanListProvider()),
      ],
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        initialRoute: 'home',
        routes: {
          'home': (_) => const HomeScreen(),
          'mapa': (_) => const MapaScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepPurple),
        ),
      ),
    );
  }
}

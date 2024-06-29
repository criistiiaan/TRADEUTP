import 'package:flutter/material.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/screen/home_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Ejecuta el código asíncrono y luego llama a runApp
  initializeApp();
}

Future<void> initializeApp() async {
  // Inicializar la base de datos
  await DatabaseHelper().database;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TradeUTP',
      home: HomePage(),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:tradeutp/asset/colors.dart';
import 'package:tradeutp/screen/favorite_page.dart';
import 'package:tradeutp/screen/home_page.dart';
import 'package:tradeutp/screen/messages/messages_page.dart';
import 'package:tradeutp/screen/notification_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Trade UTP',
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(255, 248, 255, 245), // Color de fondo
          appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 248, 255, 245), // Color del AppBar
          ),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  int selectedIndex = 0;
  bool hasTappedToStart = false;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  void setTappedToStart() {
    hasTappedToStart = true;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      body: appState.hasTappedToStart ? MainPage() : InitialPage(),
    );
  }
}

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<MyAppState>().setTappedToStart();
      },
      child: Scaffold(
        backgroundColor: colormainColor, // Fondo verde oscuro
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'lib/asset/Logo.png', // Ruta a tu logotipo
                height: 200,
              ),
            ),
            Positioned(
              bottom: 20, // Ajusta esta posición según tu necesidad
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Tocar para iniciar...',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      bottomNavigationBar: CustomBottomNavBar(),
      body: IndexedStack(
        index: appState.selectedIndex,
        children: [
          HomePage(),
          FavoritePage(),
          NotificationPage(),
          MessagesPage(),
        ],
      ),
    );
  }
}

class CustomBottomNavBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.read<MyAppState>();

    return Padding(
  padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
  child: Container(
    decoration: BoxDecoration(
      color: colormainColor, // Fondo del Container
      borderRadius: BorderRadius.circular(64),
      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.25), // Color de la sombra
          spreadRadius: 5, // Radio de difusión
          blurRadius: 4, // Radio de desenfoque
          offset: Offset(0, 4), // Cambio de posición de la sombra
        ),
      ], // Bordes redondeados,
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0), // Espaciado interno del Container
      child: GNav(
        backgroundColor: colormainColor,
        activeColor: colormainColor,
        tabBackgroundColor: Color.fromARGB(255, 231, 235, 220),
        color: Colors.white,
        padding: EdgeInsets.all(16),
        selectedIndex: appState.selectedIndex,
        onTabChange: (index) {
          appState.setSelectedIndex(index);
        },
        tabs: const [
          GButton(icon: Icons.home, text: '  Inicio'),
          GButton(icon: Icons.favorite_border, text: '  Favoritos'),
          GButton(icon: Icons.notifications, text: '  Notificaciones'),
          GButton(icon: Icons.message, text: '  Mensajes'),
        ],
      ),
    ),
  ),
);

  }
}
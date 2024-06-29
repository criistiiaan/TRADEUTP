import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:tradeutp/asset/colors.dart';
import 'package:tradeutp/screen/MessagesPage.dart';
import 'package:tradeutp/screen/favorite_page.dart';
import 'package:tradeutp/screen/home_page.dart';
import 'package:tradeutp/widget/floatingActionButtonRoute.dart';
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
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {

  int selectedIndex = 0;

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      extendBody: true, // Extender el cuerpo detrás del bottomNavigationBar
      floatingActionButton: FloatingActionButtonRoute(),
      bottomNavigationBar: CustomBottomNavBar(),
      body: IndexedStack(
        index: appState.selectedIndex,
        children: [
          HomePage(),
          FavoritePage(),
          //NotificationsScreen(),
          MessagePage(),
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5),
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
            child:Padding(
              padding: const EdgeInsets.all(12.0), // Espaciado interno del Container
              child: GNav(
                backgroundColor: colormainColor,
                activeColor: colormainColor,
                tabBackgroundColor: Color.fromARGB(255,231, 235, 220),
                color: Colors.white,  
                padding: EdgeInsets.all(16),
                selectedIndex: appState.selectedIndex,
                onTabChange: (index) {
                  appState.setSelectedIndex(index);
                },
                tabs: const[
                  GButton(icon: Icons.home,
                  text: 'Inicio'),
                GButton(icon: Icons.favorite_border,
                text: 'Favoritos'),          
                GButton(icon: Icons.notifications,
                text: 'Notificaciones'),
                GButton(icon: Icons.message, 
                text: 'Mensajes'),
            
            
                ]
          ),))
      );
    
    
  }
}

// Clase para la ventana de notificaciones






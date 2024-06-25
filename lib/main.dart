import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

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
        title: 'Namer App',
        
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      bottomNavigationBar: Padding(
        
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: Container( 
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 34, 72, 33), // Fondo del Container
            border: Border.all(
              width: 2.0, // Ancho del borde
            ),
            borderRadius: BorderRadius.circular(64), // Bordes redondeados,
        ),
        child:Padding(
          padding: const EdgeInsets.all(12.0), // Espaciado interno del Container
          child: GNav(
            backgroundColor: Color.fromARGB(255, 34, 72, 33),
            activeColor: Color.fromARGB(255,34, 72, 33),
            tabBackgroundColor: Color.fromARGB(255,231, 235, 220),
            color: Colors.white,  
            padding: EdgeInsets.all(16),
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
      ),
      body: Column(
        children: [
          Text('A random idea:'),
          Text(appState.current.asLowerCase),
          // ↓ Add this.
          ElevatedButton(
            onPressed: () {
              print('button pressed!');
            },
            child: Text('Next'),
          ),
        ],
      ),
    );
  }
}
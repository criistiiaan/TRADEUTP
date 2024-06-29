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
      bottomNavigationBar: CustomBottomNavBar(),
      body: IndexedStack(
        index: appState.selectedIndex,
        children: [
          HomeScreen(),
          FavoritesScreen(),
          NotificationsScreen(),
          MessagesScreen(),
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
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 34, 72, 33), // Fondo del Container
          border: Border.all(
            width: 2.0, // Ancho del borde
          ),
          borderRadius: BorderRadius.circular(64), // Bordes redondeados
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0), // Espaciado interno del Container
          child: GNav(
            backgroundColor: Color.fromARGB(255, 34, 72, 33),
            activeColor: Color.fromARGB(255, 34, 72, 33),
            tabBackgroundColor: Color.fromARGB(255, 231, 235, 220),
            color: Colors.white,
            padding: EdgeInsets.all(16),
            tabs: BottomNavTabs.tabs,
            selectedIndex: appState.selectedIndex,
            onTabChange: (index) {
              appState.setSelectedIndex(index);
            },
          ),
        ),
      ),
    );
  }
}

class BottomNavTabs {
  static const List<GButton> tabs = [
    GButton(
      icon: Icons.home,
      text: 'Inicio',
      textColor: Color.fromARGB(255, 34, 72, 33)
    ),
    GButton(
      icon: Icons.favorite_border,
      text: 'Favoritos',
    ),
    GButton(
      icon: Icons.notifications,
      text: 'Notificaciones',
    ),
    GButton(
      icon: Icons.message,
      text: 'Mensajes',
    ),
  ];
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos', style: TextStyle(color: Color.fromARGB(255, 34, 72, 33),fontWeight: FontWeight.bold)),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        actions: [
          IconButton(
            icon: Icon(Icons.person, color: Color.fromARGB(255, 34, 72, 33)),
            onPressed: () {
              // Acción para el botón de perfil
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Buscar',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 4, // Número de elementos en la lista
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.flaticon.es%2Ficono-gratis%2Ftransparente_5376400&psig=AOvVaw32FvACLSk4IzE9P2vTwzKL&ust=1719707442535000&source=images&cd=vfe&opi=89978449&ved=0CBEQjRxqFwoTCLCNlczH_4YDFQAAAAAdAAAAABAE'),
                      title: Text('Libro de Cálculo'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Lorem ipsum dolor sit amet, consectetur adipisc...'),
                          SizedBox(height: 5),
                          Text(
                            'Venta \$0.00',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('Vendedor'),
                        ],
                      ),
                      trailing: Icon(Icons.more_vert),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Screen'),
    );
  }
}

class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Messages Screen'),
    );
  }
}
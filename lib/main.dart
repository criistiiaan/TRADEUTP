import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:tradeutp/asset/colors.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/screen/home_page.dart';
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
        title: 'Namer App',
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
      bottomNavigationBar: CustomBottomNavBar(),
      body: IndexedStack(
        index: appState.selectedIndex,
        children: [
          HomePage(),
          FavoritesScreen(),
          NotificationPage(),
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


/*Inicio de clases para el widget*/




//clase para la ventanan home
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Home Screen'),
    );
  }
}

// clase para la ventana de favoritos
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

// Clase para la ventana de notificaciones
class NotificationsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Notifications Screen'),
    );
  }
}

// Clase para la ventana de mensajes
class MessagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
        title: Text(
          'Mensajes',
          style: TextStyle(
            color: Color.fromARGB(255, 34, 72, 33),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white, // Cambia esto si necesitas otro color de fondo
        iconTheme: IconThemeData(color: Color.fromARGB(255, 34, 72, 33)), // Cambia el color de los íconos del AppBar
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Color.fromARGB(255, 34, 72, 33), // Color del borde
                  width: 2.0, // Ancho del borde
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0), // Espaciado entre el ícono y el borde
                child: Icon(Icons.person, color: Color.fromARGB(255, 34, 72, 33)),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar( backgroundColor: Color.fromARGB(255, 34, 72, 33),
              child: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            title: Text('Luis Castro',style: TextStyle(color: Color.fromARGB(255, 34, 72, 33)),),
            subtitle: Text('Sí está disponible.', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131)),),
            trailing: Text('12:52 pm', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131)),),
            selected: true,
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsPage()),
                );
              },
          ),
          ListTile(
            leading: CircleAvatar( backgroundColor: Color.fromARGB(255, 34, 72, 33),
              child: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
            ),
            title: Text('Patricia Estrella',style: TextStyle(color: Color.fromARGB(255, 34, 72, 33)),),
            subtitle: Text('Hola, ¿Está disponible?', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131)),),
            trailing: Text('12:52 pm', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131)),),
            selected: true,
            onTap: () {
              // Acción al hacer clic en Patricia Estrella
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notificaciones',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Mensajes',
          ),
        ],
        currentIndex: 3, // Índice del elemento seleccionado
        onTap: (index) {
          // Acción al seleccionar un elemento del BottomNavigationBar
        },
      ),
    );
  }
}



class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Acción para volver atrás
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start, // Align to the start (left)
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0), // Adjust the left padding as needed
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 50),
                  SizedBox(height: 7),
                  Text('Luis Castro', style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
          ],
        ),
        centerTitle: false, // Set to false since we're aligning manually
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              reverse: true,  // This will keep the messages at the bottom
              children: <Widget>[
                _buildMessageRow('Sí, está disponible', true),
                _buildMessageRow('Hola', true),
                _buildMessageRow('Hola, ¿Está disponible?', false),
              ],
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageRow(String message, bool isSentByMe) {
    final alignment = isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final color = isSentByMe ? Color.fromARGB(255, 34, 72, 33) : Color.fromARGB(255, 235, 253, 228);
    final textColor = isSentByMe ? Colors.white : Colors.black; // Change text color based on sender
    final textSize = 15.0; // Adjust text size as needed

    return Align(
      alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: textColor,
            fontSize: textSize,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Escribe aquí...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              // Acción para enviar el mensaje
            },
          ),
        ],
      ),
    );
  }
}
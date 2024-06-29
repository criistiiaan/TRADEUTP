import 'package:flutter/material.dart';
import 'package:tradeutp/asset/colors.dart';
import 'package:tradeutp/screen/DetailsMessagePage.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
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
        iconTheme: IconThemeData(color: colormainColor),// Cambia el color de los íconos del AppBar
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: colormainColor, // Color del borde
                  width: 2.0, // Ancho del borde
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0), // Espaciado entre el ícono y el borde
                child: Icon(Icons.person, color: colormainColor),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar( backgroundColor: colormainColor,
              child: Icon(Icons.person, color: Colors.white),
            ),
            title: Text('Luis Castro',style: TextStyle(color: colormainColor,fontWeight: FontWeight.bold ),),
            subtitle: Text('Sí está disponible.', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131)),),
            trailing: Text('12:52 pm', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131)),),
            selected: true,
            onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DetailsMessagePage()),
                );
              },
          ),
          ListTile(
            leading: CircleAvatar( backgroundColor: colormainColor,
              child: Icon(Icons.person, color: Colors.white),
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
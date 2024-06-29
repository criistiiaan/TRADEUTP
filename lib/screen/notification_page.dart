
import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  backgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Color.fromARGB(255, 34, 72, 33)),
  flexibleSpace: FlexibleSpaceBar(
    background: Stack(
      children: [
        Positioned(
          left: 25.0,
          top: 55.0, // Adjust this value to move the text up or down
          child: Text(
            'Notificaciones',
            style: TextStyle(
              color: Color.fromARGB(255, 34, 72, 33),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Positioned(
          right: 25.0,
          top: 43.0, // Adjust this value to move the icon and circle up or down together
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.fromARGB(255, 34, 72, 33),
                width: 2.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Icon(Icons.person, color: Color.fromARGB(255, 34, 72, 33)),
            ),
          ),
        ),
      ],
    ),
  ),
),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Buscar',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 10), // Espacio reducido para mover el mensaje más arriba
            Center(
              child: Text(
                'No tienes notificaciones recientes.',
                style: TextStyle(
                  color: Color.fromARGB(255, 131, 131, 131),
                  fontSize: 18, // Tamaño del texto ajustado
                  fontWeight: FontWeight.w500, // Peso de la fuente ajustado
                ),
                textAlign: TextAlign.center, // Centrando el texto
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:tradeutp/screen/messages/conversation.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0), // Set the height you want
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 248, 255, 245),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 235, 253, 228)),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned(
                  left: 25.0,
                  top: 35.0, // Adjust this value to move the text up or down
                  child: Text(
                    'Mensajes',
                    style: TextStyle(
                      color: Color.fromARGB(255, 34, 72, 33),
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
                Positioned(
                  right: 25.0,
                  top: 30.0, // Adjust this value to move the icon and circle up or down together
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
            Expanded(
              child: ListView(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 34, 72, 33),
                      child: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    title: Text('Luis Castro', style: TextStyle(color: Color.fromARGB(255, 34, 72, 33))),
                    subtitle: Text('Sí está disponible.', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131))),
                    trailing: Text('12:52 pm', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131))),
                    selected: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConversationPage(name: 'Luis Castro', message: 'Sí está disponible.')),
                      );
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 34, 72, 33),
                      child: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    title: Text('Patricia Estrella', style: TextStyle(color: Color.fromARGB(255, 34, 72, 33))),
                    subtitle: Text('Hola, ¿Está disponible?', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131))),
                    trailing: Text('12:52 pm', style: TextStyle(color: Color.fromARGB(255, 131, 131, 131))),
                    selected: true,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ConversationPage(name: 'Patricia Estrella', message: 'Hola, ¿Está disponible?')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




import 'package:flutter/material.dart';

class DetailsMessagePage extends StatefulWidget {
  const DetailsMessagePage({super.key});

  @override
  State<DetailsMessagePage> createState() => _DetailsMessagePageState();
}

class _DetailsMessagePageState extends State<DetailsMessagePage> {
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
    final color = isSentByMe ? Color.fromARGB(255, 34, 72, 33) : Color.fromARGB(255, 235, 253, 228);
    final textColor = isSentByMe ? Colors.white : Colors.black; // Change text color based on sender
    const textSize = 15.0; // Adjust text size as needed

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

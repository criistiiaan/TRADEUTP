
import 'package:flutter/material.dart';

class ConversationPage extends StatefulWidget {
  final String name;
  final String message;

  const ConversationPage({super.key, required this.name, required this.message});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages.add({'message': widget.message, 'isSentByMe': false});
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.add({'message': _controller.text, 'isSentByMe': true});
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 255, 245),
        toolbarHeight: 100.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 100.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.account_circle, size: 50, color: Color.fromARGB(255, 34, 72, 33)),
                  SizedBox(height: 7),
                  Text(widget.name, style: TextStyle(fontSize: 16.0)),
                ],
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageRow(message['message'], message['isSentByMe']);
              },
            ),
          ),
          SizedBox(height: 10), // Add some space between the input bar and the bottom of the screen
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageRow(String message, bool isSentByMe) {
  final alignment = isSentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
  final color = isSentByMe ? Color.fromARGB(255, 34, 72, 33) : Color.fromARGB(255, 235, 253, 228);
  final textColor = isSentByMe ? Colors.white : Colors.black;
  final textSize = 20.0;
  final iconColor = Color.fromARGB(255, 38, 92, 40);

  return Align(
    alignment: isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isSentByMe) ...[
          SizedBox(width: 10), // Separación del ícono del margen del teléfono
          Icon(Icons.account_circle, color: iconColor, size: 30),
          SizedBox(width: 5),
        ],
        Container(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5), // Ajuste del margen horizontal
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
        if (isSentByMe) ...[
          SizedBox(width: 5),
          Icon(Icons.account_circle, color: iconColor, size: 30),
          SizedBox(width: 10), // Separación del ícono del margen del teléfono
        ],
      ],
    ),
  );
}

  Widget _buildMessageInput() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20), // Less wide
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey),
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Escribe aquí...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send, color: Colors.grey),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }
}
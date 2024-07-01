
import 'package:flutter/material.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/asset/userAccount.dart';
import 'package:intl/intl.dart';

class ConversationPage extends StatefulWidget {
  final String name;
  final int id;

  const ConversationPage({super.key, required this.id, required this.name});

  @override
  State<ConversationPage> createState() => _ConversationPageState();
}

class _ConversationPageState extends State<ConversationPage> {
  final TextEditingController _controller = TextEditingController();
  late Future<List<Map<String, dynamic>>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _loadMessage();
  }

  Future<void> _loadMessage() async {
    setState(() {
      _itemsFuture = DatabaseHelper().getMessagesForChat(widget.id);
    });
  }

  void _uploadMessage() {
    DatabaseHelper().insertMessage({
      'fromIdChat': widget.id,
      'fromIdUsers': userAccount[2],
      'mensaje': _controller.text,
      'Time': '${DateFormat('hh:mm a').format(DateTime.now())}',
      'state': 1 //1 visto 0 no visto
    });
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _uploadMessage();
        _refreshMessage();
        _controller.clear();
      });
    }
  }

  Future<void> _refreshMessage() async {
    setState(() {
      _itemsFuture = DatabaseHelper().getMessagesForChat(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    // Calcular el padding deseado (un tercio del ancho de la pantalla)
    double leftPadding = screenSize.width / 5;
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
              padding: EdgeInsets.only(left: leftPadding),
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
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Divider(height: 1, color: Colors.grey[300]), // Divider gris suave debajo del AppBar
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshMessage,
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _itemsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay mensajes previos'));
                  } else {
                    List<Map<String, dynamic>> messages = snapshot.data!;
                    return ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> message = messages[index];
                        return _buildMessageRow(message['mensaje'], userAccount[2] == message['fromIdUsers']);
                      },
                    );
                  }
                },
              ),
            ),
          ),
          SizedBox(height: 10), // Agrega algo de espacio entre la barra de entrada y la parte inferior de la pantalla
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
      margin: EdgeInsets.symmetric(horizontal: 20), // Menos ancho
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
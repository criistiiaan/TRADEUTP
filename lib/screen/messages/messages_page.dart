import 'package:flutter/material.dart';
import 'package:tradeutp/asset/database_helper.dart';
import 'package:tradeutp/asset/userAccount.dart';
import 'package:tradeutp/screen/messages/conversation.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  late Future<List<Map<String, dynamic>>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = DatabaseHelper().getAllChats(userAccount[2] as int);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(90.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 248, 255, 245),
          iconTheme: IconThemeData(color: Color.fromARGB(255, 235, 253, 228)),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              children: [
                Positioned(
                  left: 25.0,
                  top: 35.0,
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
                  top: 30.0,
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
              child: FutureBuilder<List<Map<String, dynamic>>>(
                future: _itemsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No hay chats'));
                  } else {
                    List<Map<String, dynamic>> chats = snapshot.data!;
                    return ListView.builder(
                      itemCount: chats.length,
                      itemBuilder: (context, index) {
                        return ChatMessengerDesign(
                          idVendedor: chats[index]['toUsers'],
                          chatId: chats[index]['id'],
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatMessengerDesign extends StatefulWidget {
  final int idVendedor;
  final int chatId;

  const ChatMessengerDesign({Key? key, required this.idVendedor, required this.chatId}) : super(key: key);

  @override
  State<ChatMessengerDesign> createState() => _ChatMessengerDesignState();
}

class _ChatMessengerDesignState extends State<ChatMessengerDesign> {
  late Future<Map<String, dynamic>> _lastMessageFuture;
  late Future<Map<String, dynamic>> _userFuture;

  @override
  void initState() {
    super.initState();
     _lastMessageFuture = DatabaseHelper().getLastMessagesForChat(widget.chatId)
        .then((value) => convertListToMap(value));
    _userFuture = DatabaseHelper().getSelectUsers(widget.idVendedor)
        .then((value) => convertListToMap(value));
  }
  Future<Map<String, dynamic>> convertListToMap(List<Map<String, dynamic>> list) async {
  if (list.isNotEmpty) {
    return list.first;
  } else {
    // Manejar el caso donde la lista está vacía, dependiendo de tus necesidades
    throw Exception('La lista está vacía');
  }
}

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Map<String, dynamic>>>(
  future: Future.wait([_lastMessageFuture, _userFuture]),
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(child: Text('Error: ${snapshot.error}'));
    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
      return Center(child: Text('No hay datos disponibles'));
    } else {
      List<Map<String, dynamic>> datos = snapshot.data!;

      if (datos.isEmpty) {
        return Center(child: Text('No hay datos disponibles'));
      }

      // Now you can access combinedData to get the required data
      Map<String, dynamic> lastMessage = datos[0];
      Map<String, dynamic> users = datos[1];

      return ListTile(
        leading: CircleAvatar(
          backgroundColor: Color.fromARGB(255, 34, 72, 33),
          child: Icon(Icons.person, color: Color.fromARGB(255, 255, 255, 255)),
        ),
        title: Text('${users['name']} ${users['surname']}', style: TextStyle(color: Color.fromARGB(255, 34, 72, 33))),
        subtitle: Text(lastMessage['mensaje'], style: TextStyle(color: Color.fromARGB(255, 131, 131, 131))),
        trailing: Text(lastMessage['Time'], style: TextStyle(color: Color.fromARGB(255, 131, 131, 131))),
        selected: true,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ConversationPage(id: widget.chatId,name:'${users['name']} ${users['surname']}' )),
          );
        },
      );
    }
  },
);
  }
}

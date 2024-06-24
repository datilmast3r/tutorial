import 'package:flutter/material.dart';
import 'package:volunteer/models/Usuario.dart';
import '../models/message.dart';

class ChatPage extends StatefulWidget {
  final Usuario usuario;
  const ChatPage({super.key, required this.usuario});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Message> messages = [];
  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  void fetchMessages() async {
    // Simula la obtención de mensajes desde una fuente, como Firebase
    // Esta función debe ser implementada para recuperar los mensajes reales
  }

  void sendMessage(String text) {
    // Implementar lógica para enviar mensaje
    // Actualizar la lista de mensajes y limpiar el campo de texto
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Chat")),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Align(
                  // alignment: messages[index].senderId == widget.user.id
                  //     ? Alignment.centerRight
                  //     : Alignment.centerLeft,
                  child: Container(
                      // padding: EdgeInsets.all(8.0),
                      // decoration: BoxDecoration(
                      //   color: messages[index].senderId == widget.user.id
                      //       ? Colors.blue[100]
                      //       : Colors.grey[300],
                      //   borderRadius: BorderRadius.circular(12),
                      // ),
                      // child: Text(messages[index].text),
                      ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      labelText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(messageController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

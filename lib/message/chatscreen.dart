import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'message_Service.dart';
import 'messagemodel.dart';

class ChatScreen extends StatefulWidget {
  final int receiverId;

  const ChatScreen({required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _apiService = ApiService();
  final _messageController = TextEditingController();

  late Future<List<Message>> _messagesFuture;

  @override
  void initState() {
    super.initState();
    _messagesFuture = _apiService.fetchMessagesForReceiver(widget.receiverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Seller'),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Message>>(
              future: _messagesFuture,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        title: Text(message.message!),
                        subtitle: Text(message.senderId.toString()),
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('${snapshot.error}'),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type a message',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () async {
                    if (_messageController.text.isNotEmpty) {
                      await _apiService.sendMessage(
                        senderId: 1,
                        receiverId: widget.receiverId,
                        message: _messageController.text,// replace this with the authenticated user's ID
                      );
                      _messageController.clear();
                      setState(() {
                        _messagesFuture = _apiService.fetchMessagesForReceiver(widget.receiverId);
                      });
                    }
                  },
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }

}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'messagemodel.dart';

class ApiService {
  static const String _baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Message>> fetchMessagesForReceiver(int receiverId) async {
    final response = await http.get(Uri.parse('$_baseUrl/comments?postId=$receiverId'));
    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      return jsonList.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }
  Future<Message> sendMessage({required int senderId, required int receiverId, required String message}) async {
    final response = await http.post(Uri.parse('$_baseUrl/comments'), body: {
      'postId': '$receiverId',
      'name': 'From user $senderId',
      'email': 'user$senderId@example.com',
      'body': message,
    });
    if (response.statusCode == 201) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message');
    }
  }

}

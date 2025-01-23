import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).primaryColor, // Use the theme's primary color
        title: const Text('Chat'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when pressed
          },
        ),
        elevation:
            0, // Remove elevation to match the style of the rest of your pages
      ),
      backgroundColor: Colors.white, // Consistent background for the ChatPage
      body: const Center(
        child: Text(
          "No chat available",
          style: TextStyle(fontSize: 16), // Smaller text
        ),
      ),
    );
  }
}

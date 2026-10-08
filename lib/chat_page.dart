import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:third_app/thread_screen.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Chat", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      // Listen to the users collection and show every signed up user
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Could not load users"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No users yet"));
          }

          // Do not show the person who is currently logged in
          final users = snapshot.data!.docs.where((doc) {
            return doc.id != currentUser?.uid;
          }).toList();

          if (users.isEmpty) {
            return Center(child: Text("No other users yet"));
          }

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final userData = users[index].data() as Map<String, dynamic>;
              final username = userData['username'] ?? 'User';
              final email = userData['email'] ?? '';
              final otherUserId = userData['uid'] ?? users[index].id;

              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.purple,
                  child: Text(
                    username.toString().isNotEmpty
                        ? username.toString()[0].toUpperCase()
                        : 'U',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                title: Text(username),
                subtitle: Text(email),
                onTap: () {
                  // Open the chat thread with this user
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ThreadPage(
                        otherUserId: otherUserId,
                        otherUsername: username,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:third_app/search_page.dart';

import 'auth_service.dart';
import 'login_screen.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final AuthService authService = AuthService();

  Future<void> _logout(BuildContext context) async {
    await AuthService().signOut();

    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey.shade200,
        title: Text("Google Messages"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Container(
              child: Row(
                children: [
                  Icon(Icons.search),
                  SizedBox(width: 20),
                  InkWell(onTap: () {
                    _logout(context);
                  },child: Icon(Icons.logout)),
                  SizedBox(width: 20),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/BioKit.jpg"),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/compdiag.jpg", height: 200, width: 200),
            Text(
              "Once you start a conversation, you will see it listed here",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: ((context) => SearchPage())),
              );
            },
            child: Icon(Icons.search),
          ),
          SizedBox(height: 10),
          FloatingActionButton.extended(
            icon: Icon(Icons.chat),
            onPressed: () {

            },
            label: Text("Start chat"),
          ),
        ],
      ),
    );
  }
}

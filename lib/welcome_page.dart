import 'package:flutter/material.dart';
import 'package:third_app/search_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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

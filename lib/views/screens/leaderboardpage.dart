import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:new_firebase/controllers/leadercontroller.dart';
import 'package:new_firebase/models/leader.dart';

class Leaderboardpage extends StatefulWidget {
  const Leaderboardpage({super.key});

  @override
  State<Leaderboardpage> createState() => _LeaderboardpageState();
}

class _LeaderboardpageState extends State<Leaderboardpage> {
  final leadercontroller = Leadercontroller();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 49, 9, 9),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 9, 9),
        title: const Text(
          "Leaderboard",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: StreamBuilder(
        stream: leadercontroller.list,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("Leaderlarizm mavjud emas,siz bo`ling"),
            );
          }
          final leaders = snapshot.data!.docs;
          return ListView.builder(
            itemCount: leaders.length,
            itemBuilder: (context, index) {
              final leader = Leader.fromJson(snapshot.data!.docs[index]);
              return ListTile(
                title: Text(
                  leader.email,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                ),
                subtitle: Text(
                  leader.score.toString(),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

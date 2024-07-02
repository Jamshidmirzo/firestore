import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase/services/leaderboard_sevice.dart';

class Leadercontroller extends ChangeNotifier {
  final leaderservice = LeaderboardSevice();
  Stream<QuerySnapshot> get list {
    return leaderservice.getLeaders();
  }

  getSortedLeaders() async {}

  addToleader(String email, int score) {
    leaderservice.addToLeaders(email, score);
  }
}

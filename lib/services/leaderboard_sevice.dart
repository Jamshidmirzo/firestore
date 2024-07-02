import 'package:cloud_firestore/cloud_firestore.dart';

class LeaderboardSevice {
  final leaders = FirebaseFirestore.instance.collection('leaderboards');

  Stream<QuerySnapshot> getLeaders() async* {
    yield* leaders.snapshots();
  }

  addToLeaders(String email, int score) {
    leaders.add(
      {'email': email, 'score': score},
    );
  }
}

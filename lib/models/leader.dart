import 'package:cloud_firestore/cloud_firestore.dart';

class Leader {
  String id;
  String email;
  int score;
  Leader({required this.email, required this.id, required this.score});
  factory Leader.fromJson(QueryDocumentSnapshot json) {
    return Leader(email: json['email'], id: json.id, score: json['score']);
  }
}

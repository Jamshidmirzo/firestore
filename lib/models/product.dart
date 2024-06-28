import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String question;
  List<dynamic> answers;
  int correct;
  Product(
      {required this.id,
      required this.answers,
      required this.question,
      required this.correct});

  factory Product.fromJson(QueryDocumentSnapshot query) {
    return Product(
      id: query.id,
      answers: query['answers'],
      correct: query['correct'],
      question: query['question'],
    );
  }
}

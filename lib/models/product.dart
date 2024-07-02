import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String id;
  String question;
  List<dynamic> answers;
  int correct;
  String imageUrl;
  Product(
      {required this.id,
      required this.answers,
      required this.question,
      required this.imageUrl,
      required this.correct});

  factory Product.fromJson(QueryDocumentSnapshot query) {
    return Product(
      imageUrl: query['imageURL'],
      id: query.id,
      answers: query['answers'],
      correct: query['correct'],
      question: query['question'],
    );
  }
}

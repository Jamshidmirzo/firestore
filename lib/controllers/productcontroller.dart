import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase/services/quiz_firebase_service.dart';

class Productcontroller extends ChangeNotifier {
  final firebasecontroller = QuizFirebaseService();
  Stream<QuerySnapshot> get list {
    return firebasecontroller.getProduct();
  }
  
}

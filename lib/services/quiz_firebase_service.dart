import 'package:cloud_firestore/cloud_firestore.dart';

class QuizFirebaseService {
  final _quizCOntorller = FirebaseFirestore.instance.collection('products');

  Stream<QuerySnapshot> getProduct() async* {
    yield* _quizCOntorller.snapshots();
  }

  void update(String newtitle, String id) {
    _quizCOntorller.doc(id).update({});
  }
  
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase/controllers/leadercontroller.dart';
import 'package:new_firebase/controllers/productcontroller.dart';
import 'package:new_firebase/models/product.dart';
import 'package:new_firebase/services/auth_firebase_service.dart';
import 'package:new_firebase/views/screens/signinpage.dart';
import 'package:new_firebase/views/widgets/pageviewbuilder.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List correctanswerint = [];
  final pagecontroller = PageController();
  final firebaseservice = AuthFirebaseService();
  @override
  Widget build(BuildContext context) {
    final controller = context.read<Productcontroller>();
    final leadercontroller = context.read<Leadercontroller>();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 49, 9, 9),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 49, 9, 9),
        leading: IconButton(
          onPressed: () async {
            await firebaseservice.logout();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Signinpage()),
            );
          },
          icon: const Icon(Icons.logout),
        ),
      ),
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(child: Text("Mahsulotlar mavjud emas"));
            }
            final products = snapshot.data!.docs;

            return Center(
              child: PageView.builder(
                physics: const ScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: products.length,
                controller: pagecontroller,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  final product = Product.fromJson(snapshot.data!.docs[index]);
                  final question = product.question;
                  final answers = product.answers;
                  final correctanswer = product.correct;
                  final imageurl = product.imageUrl;
                  return Pageviewbuilder(
                    correctanswer: correctanswerint,
                    imageurl: imageurl,
                    answers: answers,
                    question: question,
                    index: index,
                    correct: correctanswer,
                    nextquestion: () {
                      if (index < products.length - 1) {
                        pagecontroller.nextPage(
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeIn,
                        );
                      } else {
                        final useremail =
                            FirebaseAuth.instance.currentUser!.email;
                        leadercontroller.addToleader(
                            useremail!, correctanswerint.length);
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Quiz Completed'),
                            content: Text(
                                'You have completed the quiz. ${correctanswerint.length}'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

 // return GridView.builder(
                  //   padding: const EdgeInsets.all(20),
                  //   itemCount: question.length,
                  //   gridDelegate:
                  //       const SliverGridDelegateWithFixedCrossAxisCount(
                  //           crossAxisCount: 2,
                  //           mainAxisSpacing: 10,
                  //           crossAxisSpacing: 10),
                  //   itemBuilder: (context, index) {
                  //     return Container(
                  //       width: 50,
                  //       height: 50,
                  //       color: Colors.amber,
                  //     );
                  //   },
                  // );
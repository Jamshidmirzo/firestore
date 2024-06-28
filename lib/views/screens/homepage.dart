import 'package:flutter/material.dart';
import 'package:new_firebase/controllers/productcontroller.dart';
import 'package:new_firebase/models/product.dart';
import 'package:new_firebase/views/widgets/pageviewbuilder.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int currentIndex = 0;
  Map<int, int> selectedAnswers = {};

  void _nextQuestion() {
    pagecontroller.nextPage(
        duration: const Duration(seconds: 3), curve: Curves.easeIn);
  }

  final pagecontroller = PageController();
  @override
  Widget build(BuildContext context) {
    final controller = context.read<Productcontroller>();
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
      body: SafeArea(
        child: StreamBuilder(
          stream: controller.list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data == null) {
              return const Center(
                child: Text("Mahsulotlar mavjud emas"),
              );
            }
            final products = snapshot.data!.docs;

            return products.isEmpty
                ? const Center(
                    child: Text("Mahsulotlar mavjud emas"),
                  )
                : Center(
                    child: PageView.builder(
                      physics:
                          const ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: products.length,
                      controller: pagecontroller,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        final product =
                            Product.fromJson(snapshot.data!.docs[index]);
                        final question = product.question;
                        final answers = product.answers;
                        int correctanswer = product.correct;

                        return Pageviewbuilder(
                            answers: answers,
                            question: question,
                            index: index,
                            correct: correctanswer,
                            nextquestion: _nextQuestion);
                      },
                    ),
                  );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Pageviewbuilder extends StatefulWidget {
  final String question;
  final List<dynamic> answers;
  final int index;
  final int correct;
  final Function nextquestion;

  Pageviewbuilder({
    super.key,
    required this.answers,
    required this.question,
    required this.index,
    required this.nextquestion,
    required this.correct,
  });

  @override
  State<Pageviewbuilder> createState() => _PageviewbuilderState();
}

class _PageviewbuilderState extends State<Pageviewbuilder> {
  Map<int, int> selectedAnswers = {};
  bool isChecked = false;
  int correctIndex = -1;
  bool isTogri = false;

  void toggleCheck() {
    isChecked = true;
    setState(() {});
  }

  final pagecontroller = PageController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.question,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
        ),
        for (int i = 0; i < widget.answers.length; i++)
          ListTile(
            title: Text(
              widget.answers[i],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            trailing: IconButton(
              onPressed: () {
                isChecked = true;
                setState(() {
                  correctIndex = i;
                  isTogri = (i == widget.correct);
                });
                widget.nextquestion();
              },
              icon: i == correctIndex
                  ? Icon(Icons.check_box)
                  : Icon(Icons.check_box_outline_blank),
            ),
          ),
        if (isChecked)
          isTogri
              ? Lottie.asset('assets/lotties/done.json',
                  width: 200, height: 200)
              : Lottie.asset('assets/lotties/incorrect.json',
                  width: 100, height: 100),
      ],
    );
  }
}

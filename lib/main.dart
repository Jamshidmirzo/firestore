import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase/controllers/productcontroller.dart';
import 'package:new_firebase/firebase_options.dart';
import 'package:new_firebase/views/screens/homepage.dart';
import 'package:provider/provider.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) {
      return Productcontroller();
    }, builder: (context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        )),
        home: Homepage(),
      );
    });
  }
}

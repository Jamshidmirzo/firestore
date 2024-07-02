import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_firebase/controllers/leadercontroller.dart';
import 'package:new_firebase/controllers/productcontroller.dart';
import 'package:new_firebase/firebase_options.dart';
import 'package:new_firebase/views/screens/bottomnavbar.dart';
import 'package:new_firebase/views/screens/homepage.dart';
import 'package:new_firebase/views/screens/signinpage.dart';
import 'package:provider/provider.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) {
              return Productcontroller();
            },
          ),
          ChangeNotifierProvider(
            create: (context) {
              return Leadercontroller();
            },
          ),
        ],
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                }
                return snapshot.data == null ? Signinpage() : Bottomnavbar();
              },
            ),
          );
        });
  }
}

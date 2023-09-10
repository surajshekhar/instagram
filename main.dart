import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram/providers/usert_provider.dart';
import 'package:instagram/responsive/Mobileversion.dart';
import 'package:instagram/responsive/Webscreenversion.dart';
import 'package:instagram/responsive/responsive_screen.dart';
import 'package:instagram/utility/global_variable.dart';
import 'package:instagram/screens/SignUp_screen.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:provider/provider.dart';
import 'package:foundation_flutter/foundation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAZXtlXzu2Y7ulohwB7JqKL2g4nkIMmG1M",
        appId: "1:1033737281695:web:b4ed17b921a21ffd3b82aa",
        messagingSenderId: '1033737281695',
        projectId: "instagram-clone-52a91",
        storageBucket: "instagram-clone-52a91.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const Instagram());
}

class Instagram extends StatelessWidget {
  const Instagram({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(),
        // home: const Responsive(
        //   mobilescreenlayout: mobilescreenlayout(),
        //   webscreenslayout: webscreenslayout(),
        // ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return const Responsive(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Center(
                    child: Text('${snapshot.error}'),
                  ),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }
            return const LoginScreen();
          },
        ),
      ),
    );
  }
}

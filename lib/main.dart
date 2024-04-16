import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/database_repository.dart';
import 'package:lets_chat/firebase_options.dart';
import 'package:lets_chat/logic/user/user_provider.dart';
import 'package:lets_chat/presentation/auth/complete_profile/complete_profile_page.dart';
import 'package:lets_chat/presentation/auth/complete_profile/complete_profile_provider/complete_profile_provider.dart';
import 'package:lets_chat/presentation/auth/login/login_page.dart';
import 'package:lets_chat/presentation/auth/login/login_provider/login_provider.dart';
import 'package:lets_chat/presentation/auth/signup/sign_up_page.dart';
import 'package:lets_chat/presentation/auth/signup/sign_up_provider/sign_up_provider.dart';
import 'package:lets_chat/presentation/auth/splash/splash_page.dart';
import 'package:lets_chat/presentation/chat_room/chat_room_provider/chat_room_provider.dart';
import 'package:lets_chat/presentation/home/home_page.dart';
import 'package:lets_chat/core/routes.dart';
import 'package:lets_chat/presentation/home/home_provider/home_provider.dart';
import 'package:lets_chat/presentation/message/message_provider/message_provider.dart';
import 'package:lets_chat/presentation/profile/profile_provider/profile_provider.dart';
import 'package:lets_chat/presentation/search/search_provider/search_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        onGenerateRoute: Routes.generateRoute,
        home: const SplashPage(),
        // home: const CompleteProfilePage(),
      ),
    );
  }
}

class MyProvider extends Provider {
  MyProvider({required super.create}) {}
}

// class MyAppLoggedIn extends StatelessWidget {
//   const MyAppLoggedIn({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => UserProvider()),
//         ChangeNotifierProvider(create: (context) => SignUpProvider(context)),
//         ChangeNotifierProvider(create: (context) => LoginProvider()),
//         ChangeNotifierProvider(create: (context) => CompleteProfileProvider()),
//       ],
//       child: MaterialApp(
//         title: 'Flutter Demo',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           useMaterial3: true,
//         ),
//         onGenerateRoute: Routes.generateRoute,
//         home: const HomePage(),
//         // home: const CompleteProfilePage(),
//       ),
//     );
//   }
// }

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/logic/user/user_provider.dart';
import 'package:lets_chat/presentation/auth/login/login_page.dart';
import 'package:lets_chat/presentation/home/home_page.dart';
import 'package:lets_chat/presentation/widgets/default_title.dart';
import 'package:lets_chat/presentation/widgets/gap_widget.dart';
import 'package:provider/provider.dart';

import '../../../data/models/user_model.dart';
import '../../../data/repository/database_repository.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/splash";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Timer(const Duration(seconds: 3), () async {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // it gets the user data
        UserModel? loggedInUser =
            await DatabaseRepository.getUserData(user.uid);
        if (loggedInUser != null) {
          // if user data is not null then store it in UserProvider
          if (context.mounted) {
            Provider.of<UserProvider>(context, listen: false)
                .setUser(loggedInUser);
            Navigator.pushReplacementNamed(context, HomePage.routeName);
            return;
          }
        }
      }
      if (context.mounted) {
        Navigator.pushReplacementNamed(context, LoginPage.routeName);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DefaultTitle(text: "Let's Chat"),
            GapWidget(),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

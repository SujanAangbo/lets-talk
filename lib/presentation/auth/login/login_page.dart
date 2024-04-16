import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/logic/user/user_provider.dart';
import 'package:lets_chat/presentation/auth/login/login_provider/login_provider.dart';
import 'package:lets_chat/presentation/auth/signup/sign_up_page.dart';
import 'package:lets_chat/presentation/helper/UIHelper.dart';
import 'package:lets_chat/presentation/home/home_page.dart';
import 'package:lets_chat/presentation/widgets/default_button.dart';
import 'package:lets_chat/presentation/widgets/default_title.dart';
import 'package:lets_chat/presentation/widgets/gap_widget.dart';
import 'package:provider/provider.dart';

import '../../../core/validators.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/login";

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: loginProvider.loginFormState,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DefaultTitle(text: "Let's Chat"),
                  const GapWidget(),
                  TextFormField(
                    validator: Validators.emailValidator,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: loginProvider.emailController,
                    decoration:
                        const InputDecoration(labelText: "Email Address"),
                  ),
                  const GapWidget(),
                  TextFormField(
                    obscureText: true,
                    validator: Validators.passwordValidator,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    controller: loginProvider.passwordController,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                    ),
                  ),
                  const GapWidget(
                    size: 16,
                  ),
                  DefaultButton(
                    text: "Login",
                    onPressed: () async {
                      UserModel? loggedInUser =
                          await Provider.of<LoginProvider>(context,
                                  listen: false)
                              .login(context);
                      if (loggedInUser != null) {
                        if (context.mounted) {
                          Provider.of<UserProvider>(context, listen: false)
                              .setUser(loggedInUser);
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacementNamed(
                              context, HomePage.routeName);
                          UIHelper.showSnackbar(
                              context, "Logged in successful", Colors.green);
                        }
                      }
                    },
                    color: Colors.blue,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Don't have an account?"),
          CupertinoButton(
            onPressed: () {
              Navigator.pushNamed(context, SignUpPage.routeName);
            },
            padding: const EdgeInsets.all(8),
            child: const Text("Sign Up"),
          )
        ],
      ),
    );
  }
}

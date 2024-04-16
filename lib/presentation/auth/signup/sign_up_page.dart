import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/presentation/auth/signup/sign_up_provider/sign_up_provider.dart';
import 'package:lets_chat/presentation/helper/UIHelper.dart';
import 'package:provider/provider.dart';

import '../../../core/validators.dart';
import '../../widgets/default_button.dart';
import '../../widgets/default_title.dart';
import '../../widgets/gap_widget.dart';
import '../complete_profile/complete_profile_page.dart';

class SignUpPage extends StatefulWidget {
  static const String routeName = "/sign_up";

  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Form(
            key: signUpProvider.signUpFormState,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const DefaultTitle(text: "Let's Chat"),
                  const GapWidget(),
                  TextFormField(
                    controller: signUpProvider.emailController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    validator: Validators.emailValidator,
                    decoration: const InputDecoration(
                      label: Text("Email Address"),
                    ),
                  ),
                  const GapWidget(),
                  TextFormField(
                    obscureText: true,
                    validator: Validators.passwordValidator,
                    controller: signUpProvider.passwordController,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.visiblePassword,
                    decoration: const InputDecoration(
                      label: Text("Password"),
                    ),
                  ),
                  const GapWidget(),
                  TextFormField(
                    obscureText: true,
                    controller: signUpProvider.cPasswordController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.visiblePassword,
                    validator: (value) {
                      return Validators.cPasswordValidator(
                          value, signUpProvider.passwordController.text);
                    },
                    decoration: const InputDecoration(
                      label: Text("Confirm Password"),
                    ),
                  ),
                  const GapWidget(
                    size: 16,
                  ),
                  DefaultButton(
                    text: "Sign Up",
                    onPressed: () async {
                      UserModel? signUpUser =
                          await signUpProvider.signUp(context);
                      if (signUpUser != null) {
                        if (context.mounted) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                          Navigator.pushReplacementNamed(
                              context, CompleteProfilePage.routeName,
                              arguments: signUpUser);
                          UIHelper.showSnackbar(
                              context, "SignUp successful", Colors.green);
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
          const Text("Already have an account?"),
          CupertinoButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: const EdgeInsets.all(8),
            child: const Text("Login"),
          )
        ],
      ),
    );
  }
}

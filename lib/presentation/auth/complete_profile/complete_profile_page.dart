import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lets_chat/core/colors.dart';
import 'package:lets_chat/core/validators.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/logic/images/images.dart';
import 'package:lets_chat/logic/user/user_provider.dart';
import 'package:lets_chat/presentation/auth/complete_profile/complete_profile_provider/complete_profile_provider.dart';
import 'package:lets_chat/presentation/home/home_page.dart';
import 'package:lets_chat/presentation/widgets/default_title.dart';
import 'package:provider/provider.dart';

import '../../widgets/default_button.dart';
import '../../widgets/gap_widget.dart';

class CompleteProfilePage extends StatefulWidget {
  static const String routeName = "/complete_profile";

  UserModel user;

  CompleteProfilePage({super.key, required this.user});

  @override
  State<CompleteProfilePage> createState() => _CompleteProfilePageState();
}

class _CompleteProfilePageState extends State<CompleteProfilePage> {
  @override
  Widget build(BuildContext context) {
    final completeProfileProvider =
        Provider.of<CompleteProfileProvider>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: completeProfileProvider.profileState,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const GapWidget(),
                const DefaultTitle(text: "Complete Profile"),
                const GapWidget(
                  size: 24,
                ),
                CupertinoButton(
                  onPressed: completeProfileProvider.pickProfilePicture,
                  padding: EdgeInsets.zero,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage:
                        completeProfileProvider.profileImage != null
                            ? FileImage(completeProfileProvider.profileImage!)
                            : null,
                    child: completeProfileProvider.profileImage != null
                        ? null
                        : Icon(
                            Icons.person,
                            color: AppColors.primaryColor,
                            size: 60,
                          ),
                  ),
                ),
                const GapWidget(),
                completeProfileProvider.errorMessage != null
                    ? Text(
                        completeProfileProvider.errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      )
                    : const SizedBox(),
                const GapWidget(),
                TextFormField(
                  controller: completeProfileProvider.usernameController,
                  // validator: (value) {
                  //   return Validators.cPasswordValidator(
                  //       value, signUpProvider.passwordController.text);
                  // },
                  validator: Validators.commonTextValidator,
                  decoration: const InputDecoration(
                    label: Text("Username"),
                  ),
                ),
                const GapWidget(
                  size: 16,
                ),
                DefaultButton(
                  text: "Continue",
                  onPressed: () async {
                    bool isUpdated = await completeProfileProvider
                        .updateProfile(context, widget.user);
                    if (isUpdated) {
                      if (context.mounted) {
                        Provider.of<UserProvider>(context, listen: false)
                            .setUser(widget.user);
                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacementNamed(
                            context, HomePage.routeName);
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
    );
  }
}

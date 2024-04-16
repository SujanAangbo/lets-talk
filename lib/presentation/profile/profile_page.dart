import 'package:flutter/material.dart';
import 'package:lets_chat/core/colors.dart';
import 'package:lets_chat/presentation/profile/profile_provider/profile_provider.dart';
import 'package:lets_chat/presentation/widgets/cached_circle_image.dart';
import 'package:lets_chat/presentation/widgets/default_progress_bar.dart';
import 'package:lets_chat/presentation/widgets/error_message_widget.dart';
import 'package:lets_chat/presentation/widgets/gap_widget.dart';
import 'package:provider/provider.dart';
import '../auth/login/login_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return profileProvider.isLoading()
        ? const DefaultProgressBar()
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CachedCircleImage(
                imageUrl: profileProvider.user!.profile!,
                size: 80,
              ),
              const GapWidget(),
              Text(
                profileProvider.user!.name ?? "Unknown",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                profileProvider.user!.email!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                profileProvider.user!.uid!,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const GapWidget(),
              const GapWidget(),
              TextButton.icon(
                onPressed: () async {
                  await profileProvider.logout(context);
                  if (context.mounted) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacementNamed(
                        context, LoginPage.routeName);
                  }
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                label: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ));
  }
}

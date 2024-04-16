import 'package:flutter/cupertino.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/presentation/auth/complete_profile/complete_profile_page.dart';
import 'package:lets_chat/presentation/auth/complete_profile/complete_profile_provider/complete_profile_provider.dart';
import 'package:lets_chat/presentation/auth/login/login_page.dart';
import 'package:lets_chat/presentation/auth/login/login_provider/login_provider.dart';
import 'package:lets_chat/presentation/auth/signup/sign_up_page.dart';
import 'package:lets_chat/presentation/auth/signup/sign_up_provider/sign_up_provider.dart';
import 'package:lets_chat/presentation/auth/splash/splash_page.dart';
import 'package:lets_chat/presentation/chat_room/chat_room_page.dart';
import 'package:lets_chat/presentation/chat_room/chat_room_provider/chat_room_provider.dart';
import 'package:lets_chat/presentation/home/home_page.dart';
import 'package:lets_chat/presentation/home/home_provider/home_provider.dart';
import 'package:lets_chat/presentation/message/message_provider/message_provider.dart';
import 'package:lets_chat/presentation/search/search_page.dart';
import 'package:lets_chat/presentation/search/search_provider/search_provider.dart';
import 'package:provider/provider.dart';

import '../presentation/profile/profile_provider/profile_provider.dart';

class Routes {
  static Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.routeName:
        return CupertinoPageRoute(
          builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => HomeProvider()),
              ChangeNotifierProvider(create: (_) => MessageProvider()),
              ChangeNotifierProvider(create: (_) => SearchProvider()),
              ChangeNotifierProvider(create: (_) => ProfileProvider()),
            ],
            child: const HomePage(),
          ),
        );
      case LoginPage.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => LoginProvider(),
            child: const LoginPage(),
          ),
        );
      case SignUpPage.routeName:
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => SignUpProvider(),
            child: const SignUpPage(),
          ),
        );
      case CompleteProfilePage.routeName:
        UserModel user = settings.arguments as UserModel;
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (context) => CompleteProfileProvider(),
            child: CompleteProfilePage(user: user),
          ),
        );
      case SplashPage.routeName:
        return CupertinoPageRoute(
          builder: (context) => const SplashPage(),
        );
      case ChatRoomPage.routeName:
        Map<String, dynamic> args = settings.arguments as Map<String, dynamic>;
        return CupertinoPageRoute(
          builder: (context) => ChangeNotifierProvider(
            create: (_) => ChatRoomProvider(),
            child: ChatRoomPage(
              chatRoom: args['chat_room'],
              friend: args['friend'],
            ),
          ),
        );
      default:
        return CupertinoPageRoute(
          builder: (context) => const LoginPage(),
        );
    }
  }
}

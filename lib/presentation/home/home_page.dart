import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/core/colors.dart';
import 'package:lets_chat/data/models/chatroom_user_model.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/logic/formatters/formatters.dart';
import 'package:lets_chat/logic/user/user_provider.dart';
import 'package:lets_chat/presentation/auth/login/login_page.dart';
import 'package:lets_chat/presentation/chat_room/chat_room_page.dart';
import 'package:lets_chat/presentation/helper/UIHelper.dart';
import 'package:lets_chat/presentation/home/home_provider/home_provider.dart';
import 'package:lets_chat/presentation/message/message_page.dart';
import 'package:lets_chat/presentation/message/message_provider/message_provider.dart';
import 'package:lets_chat/presentation/search/search_page.dart';
import 'package:lets_chat/presentation/widgets/default_progress_bar.dart';
import 'package:lets_chat/presentation/widgets/error_message_widget.dart';
import 'package:provider/provider.dart';

import '../profile/profile_page.dart';
import '../widgets/cached_circle_image.dart';

class HomePage extends StatefulWidget {
  static const String routeName = "/home";

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    log('Home Page');
    setState(() {});
    super.initState();
  }

  List<Widget> pages = const [
    MessagePage(),
    SearchPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<HomeProvider>(context);
    return Scaffold(
      appBar: homeProvider.index == 0
          ? AppBar(
              backgroundColor: Colors.lightBlue,
              centerTitle: true,
              title: Text(
                "Let's talk".toUpperCase(),
                // style: const TextStyle(color: Colors.white),
              ),
            )
          : null,
      body: pages[homeProvider.index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          homeProvider.changePage(index);
        },
        selectedItemColor: AppColors.primaryColor,
        currentIndex: homeProvider.index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   shape: const CircleBorder(),
      //   child: const Icon(
      //     Icons.search,
      //   ),
      //   onPressed: () {
      //     Navigator.pushNamed(context, SearchPage.routeName);
      //   },
      // )

      // IconButton(
      //
      //     onPressed: () {}),
    );
  }
}

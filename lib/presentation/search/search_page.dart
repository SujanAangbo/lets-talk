import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lets_chat/data/models/chat_room_model.dart';
import 'package:lets_chat/data/models/user_model.dart';
import 'package:lets_chat/data/repository/chat_room_repository.dart';
import 'package:lets_chat/presentation/chat_room/chat_room_page.dart';
import 'package:lets_chat/presentation/search/search_provider/search_provider.dart';
import 'package:lets_chat/presentation/widgets/cached_circle_image.dart';
import 'package:lets_chat/presentation/widgets/error_message_widget.dart';
import 'package:lets_chat/presentation/widgets/gap_widget.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const String routeName = "/search";

  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSearched = false;

  @override
  Widget build(BuildContext context) {
    final searchProvider = Provider.of<SearchProvider>(context);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchProvider.searchController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Enter username or email",
                        border: OutlineInputBorder(),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 0, horizontal: 8),
                      ),
                      onChanged: (_) {
                        searchProvider.setDataNull();
                      },
                      onSubmitted: (value) {
                        searchProvider.searchUser();
                      },
                    ),
                  ),
                  IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      // isSearched = true;
                      Provider.of<SearchProvider>(context, listen: false)
                          .searchUser();
                    },
                    icon: const Icon(Icons.search),
                  ),
                ],
              ),
              const GapWidget(),
              searchProvider.isDataEmpty() ==
                      null // check if null i.e. no search done by user
                  ? const SizedBox()
                  : searchProvider
                          .isDataEmpty()! // check if empty i.e. searched but no user found
                      ? ErrorMessageWidget(message: "No user found")
                      : ListView.builder(
                          // otherwise i.e. searched and user found
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: searchProvider.searchUsers!.length,
                          itemBuilder: (context, index) {
                            UserModel user = searchProvider.searchUsers![index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                user.name ?? "Undefined",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                user.email.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              leading: CachedCircleImage(
                                imageUrl: user.profile!,
                              ),
                              trailing: const Icon(Icons.arrow_forward_ios),
                              onTap: () async {
                                print(user.uid);
                                ChatRoomModel? chatRoom =
                                    await ChatRoomRepository.getChatRoom(
                                        user.uid!);

                                if (chatRoom != null) {
                                  Map<String, dynamic> args = {
                                    "chat_room": chatRoom,
                                    "friend": user,
                                  };
                                  if (context.mounted) {
                                    Navigator.pushNamed(
                                      context,
                                      ChatRoomPage.routeName,
                                      arguments: args,
                                    );
                                  }
                                }
                              },
                            );
                          },
                        )
            ],
          ),
        ),
      ),
    );
  }
}

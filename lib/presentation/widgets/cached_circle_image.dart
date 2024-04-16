import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/models/chatroom_user_model.dart';

class CachedCircleImage extends StatelessWidget {
  CachedCircleImage({
    super.key,
    required this.imageUrl,
    this.size = 56,
  });

  final String imageUrl;
  double size;

  // final ChatRoomUserModel friendChat;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: size,
      width: size,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        backgroundImage: imageProvider,
      ),
      placeholder: (context, str) => const CircleAvatar(
        backgroundImage: AssetImage("assets/images/person.jpeg"),
      ),
      errorWidget: (context, str, obj) => const CircleAvatar(
        backgroundImage: AssetImage("assets/images/person.jpeg"),
      ),
      fit: BoxFit.cover,
    );
  }
}

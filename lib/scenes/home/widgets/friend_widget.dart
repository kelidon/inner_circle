import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../common/app_routes.dart';
import '../../../data/models/friend_model.dart';
import '../../update_friend/widgets/avatar_widget.dart';

class FriendWidget extends StatelessWidget {
  const FriendWidget({super.key, required this.friend});

  final Friend friend;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pushNamed(AppRoutes.updateFriend, arguments: friend),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 8,
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AvatarWidget(),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(friend.name),
                const SizedBox(height: 8),
                Text(DateFormat(DateFormat.MONTH_DAY).format(friend.birthday))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

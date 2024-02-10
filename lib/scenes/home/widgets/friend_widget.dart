import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../blocs/friends/friends_cubit.dart';
import '../../../common/app_routes.dart';
import '../../../data/models/friend_model.dart';
import '../../update_friend/widgets/avatar_widget.dart';

class FriendWidget extends StatelessWidget {
  const FriendWidget({super.key, required this.friend});

  final Friend friend;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(AppRoutes.updateFriend, arguments: friend)
          .then((value) => context.read<FriendsCubit>().loadFriends()),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 16,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AvatarWidget(date: friend.birthday.day),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(friend.name, style: const TextStyle(fontSize: 22)),
                //const SizedBox(height: 4),
                Text(
                  DateFormat(DateFormat.YEAR).format(friend.birthday),
                  style: TextStyle(color: Colors.white.withOpacity(0.4)),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

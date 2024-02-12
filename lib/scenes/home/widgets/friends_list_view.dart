import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:intl/intl.dart';

import '../../../data/models/friend_model.dart';
import 'friend_widget.dart';

class FriendsListView extends StatelessWidget {
  final List<Friend> friends;

  const FriendsListView(this.friends, {super.key});

  @override
  Widget build(BuildContext context) {
    print("FriendsListView");
    var mappedFriends = <int, List<Friend>>{};
    for (var e in friends) {
      var month = e.birthday.month;
      if (mappedFriends[month] == null) {
        mappedFriends[month] = [e];
      } else {
        mappedFriends[month]!.add(e);
      }
    }

    // var currentMonth = DateTime.now().month;
    // var sortedMonth = mapped.keys.toList();
    // sortedMonth.sort();
    // var monthOrder = [
    //   ...mapped.keys.where((e) => e >= currentMonth),
    //   ...mapped.keys.where((e) => e < currentMonth)
    // ];

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        for (var monthInfo in mappedFriends.keys) ...[
          SliverAppBar(
            title: GlowText(
              DateFormat(DateFormat.MONTH).format(mappedFriends[monthInfo]![0].birthday),
              glowColor: Colors.black.withOpacity(0.5),
              blurRadius: 10,
            ),
            pinned: true,
            backgroundColor: const Color(0xFF011001),
            elevation: 100,
          ),
          SliverList.separated(
            itemCount: mappedFriends[monthInfo]!.length + 2,
            itemBuilder: (_, i) => i == 0 || i == mappedFriends[monthInfo]!.length + 1
                ? const SizedBox.shrink()
                : FriendWidget(
                    friend: mappedFriends[monthInfo]![i - 1],
                  ),
            separatorBuilder: (_, i) => Divider(
              height: 0.5,
              color: Colors.white.withOpacity(0.1),
            ),
          ),
        ]
      ],
    );
  }
}

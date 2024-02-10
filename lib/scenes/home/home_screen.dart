import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inner_circle/blocs/friends/friends_cubit.dart';
import 'package:inner_circle/common/app_colors.dart';
import 'package:inner_circle/common/app_routes.dart';
import 'package:inner_circle/scenes/home/widgets/friend_widget.dart';
import 'package:intl/intl.dart';
import 'package:neon/neon.dart';

import '../../data/models/friend_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const appName = 'inner circle';

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Neon(
          text: appName,
          color: AppColors.primary,
          fontSize: 24,
          font: NeonFont.Beon,
          glowing: true,
          glowingDuration: const Duration(seconds: 4),
          flickeringLetters: const [0, 1],
          blurRadius: 50,
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .pushNamed(AppRoutes.updateFriend)
            .then((value) => context.read<FriendsCubit>().loadFriends()),
        child: const Icon(Icons.add_outlined),
      ),
      body: BlocBuilder<FriendsCubit, FriendsState>(
        builder: (_, state) {
          switch (state) {
            case DataState():
              var mappedFriends = <int, List<Friend>>{};
              for (var e in state.friends) {
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
                      title: Text(DateFormat(DateFormat.MONTH)
                          .format(mappedFriends[monthInfo]![0].birthday)),
                      pinned: true,
                      backgroundColor: Color(0xFF152416),
                      elevation: 100,
                    ),
                    SliverList.separated(
                      itemCount: mappedFriends[monthInfo]!.length + 2,
                      itemBuilder: (_, i) => i == 0 || i == mappedFriends[monthInfo]!.length + 1
                          ? const SizedBox.shrink()
                          : FriendWidget(
                              friend: mappedFriends[monthInfo]![i - 1],
                            ),
                      separatorBuilder: (_, i) => const Divider(
                        height: 1,
                      ),
                    ),
                  ]
                ],
              );
            case LoadingState():
              return const Center(
                child: CircularProgressIndicator(),
              );
          }
        },
      ),
    ));
  }
}

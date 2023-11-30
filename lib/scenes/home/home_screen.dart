import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inner_circle/blocs/friends/friends_cubit.dart';
import 'package:inner_circle/common/app_colors.dart';
import 'package:inner_circle/common/app_routes.dart';
import 'package:inner_circle/scenes/home/widgets/friend_widget.dart';
import 'package:neon/neon.dart';

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
        onPressed: () => Navigator.of(context).pushNamed(AppRoutes.updateFriend),
        child: const Icon(Icons.add_outlined),
      ),
      body: BlocBuilder<FriendsCubit, FriendsState>(
        builder: (_, state) {
          return switch (state) {
            DataState d => Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemCount: d.friends.length,
                    separatorBuilder: (_, __) => const Divider(),
                    itemBuilder: (_, i) => FriendWidget(
                          friend: d.friends[i],
                        )),
              ),
            LoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
          };
        },
      ),
    ));
  }
}

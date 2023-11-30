import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inner_circle/data/repos/friends_repo.dart';

import '../blocs/friends/friends_cubit.dart';
import '../data/models/friend_model.dart';
import '../scenes/home/home_screen.dart';
import '../scenes/update_friend/update_friend_screen.dart';

class AppRoutes {
  static final _appRoutes = AppRoutes._internal();

  factory AppRoutes() {
    return _appRoutes;
  }

  AppRoutes._internal();

  static const String home = 'home';
  static const String updateFriend = 'updateFriend';

  static Route? onGenerateRoute(RouteSettings settings) {
    final Widget child;
    final FriendsRepo friendsRepo = FriendsRepo();
    final FriendsCubit friendsCubit = FriendsCubit(repo: friendsRepo)..loadFriends();
    switch (settings.name) {
      case home:
        child = BlocProvider.value(
          value: friendsCubit,
          child: const HomeScreen(),
        );
      case updateFriend:
        Friend? friend = settings.arguments != null ? settings.arguments as Friend : null;
        child = BlocProvider.value(
          value: friendsCubit,
          child: UpdateFriendScreen(
            friend: friend,
          ),
        );
      default:
        child = Container();
    }
    return MaterialPageRoute(builder: (_) => child);
  }
}

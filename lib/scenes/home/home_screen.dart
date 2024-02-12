import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inner_circle/blocs/friends/friends_cubit.dart';
import 'package:inner_circle/common/app_colors.dart';
import 'package:inner_circle/common/app_routes.dart';
import 'package:inner_circle/scenes/home/widgets/friends_calendar_view.dart';
import 'package:inner_circle/scenes/home/widgets/friends_list_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

const appName = 'inner circle';

class _HomeScreenState extends State<HomeScreen> {
  bool isCalendarView = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Center(
          child: GlowText(
            appName,
            style: GoogleFonts.orbitron(
              color: AppColors.schemeSeedLight,
              fontSize: 25,
            ),
            glowColor: AppColors.schemeSeedLight,
            blurRadius: 20,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: "1",
            onPressed: () => setState(() {
              isCalendarView = !isCalendarView;
            }),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 333),
              child: isCalendarView
                  ? const Icon(
                      Icons.list_alt_outlined,
                      key: Key("FriendsListFab"),
                    )
                  : const Icon(
                      Icons.calendar_month_outlined,
                      key: Key("FriendsCalendarFab"),
                    ),
              transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                //alignment: Alignment.topCenter,
                child: child,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: "2",
            onPressed: () => Navigator.of(context)
                .pushNamed(AppRoutes.updateFriend)
                .then((value) => context.read<FriendsCubit>().loadFriends()),
            child: const Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: BlocBuilder<FriendsCubit, FriendsState>(
        //buildWhen: (prev, curr)=>,
        builder: (_, state) {
          switch (state) {
            case DataState():
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 333),
                switchInCurve: Curves.bounceIn,
                switchOutCurve: Curves.bounceOut,
                child: isCalendarView
                    ? FriendsCalendarView(
                        state.friends,
                        key: Key("FriendsCalendarView${state.friends.length}"),
                      )
                    : FriendsListView(
                        state.friends,
                        key: Key("FriendsListView${state.friends.length}"),
                      ),
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

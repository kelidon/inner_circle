import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/friend_model.dart';
import '../../data/repos/friends_repo.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit({required this.repo}) : super(LoadingState());

  final FriendsRepo repo;

  Future<void> addFriend(Friend newFriend) async {
    emit(LoadingState());
    await repo.createFriend(newFriend);
    emit(DataState([...repo.friends]));
  }

  Future<void> loadFriends() async {
    emit(LoadingState());
    var friends = await repo.readFriends();
    emit(DataState([...friends]));
  }

  Future<void> editFriend(Friend editFriend) async {
    emit(LoadingState());
    await repo.updateFriend(editFriend);
    emit(DataState([...repo.friends]));
  }

  Future<void> removeFriend(Friend dltFriend) async {
    emit(LoadingState());
    await repo.deleteFriend(dltFriend);
    emit(DataState([...repo.friends]));
  }
}

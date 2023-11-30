part of 'friends_cubit.dart';

@immutable
sealed class FriendsState {}

class DataState extends FriendsState {
  final List<Friend> friends;

  DataState(this.friends) {
    friends.sort((a, b) => b.birthday.compareTo(a.birthday));
  }
}

class LoadingState extends FriendsState {}

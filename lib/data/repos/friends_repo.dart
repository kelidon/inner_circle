import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/friend_model.dart';

const _friendsKey = 'friends';

class FriendsRepo {
  static final _friendsRepo = FriendsRepo._internal();

  factory FriendsRepo() {
    return _friendsRepo;
  }

  FriendsRepo._internal();

  final List<Friend> _friends = [];

  List<Friend> get friends => _friends;

  Future<void> createFriend(Friend newFriend) async {
    var prefs = await SharedPreferences.getInstance();

    _friends.add(newFriend);

    await prefs.setStringList(_friendsKey, _friends.map((e) => jsonEncode(e.toJson())).toList());
  }

  Future<List<Friend>> readFriends() async {
    var prefs = await SharedPreferences.getInstance();
    _friends.clear();

    var data = prefs.getStringList(_friendsKey) ?? [];
    _friends
        .addAll(data.map((e) => Friend.fromJson(jsonDecode(e) as Map<String, dynamic>)).toList());

    return _friends;
  }

  Future<void> updateFriend(Friend updFriend) async {
    var prefs = await SharedPreferences.getInstance();

    _friends.removeWhere((e) => e.id == updFriend.id);
    _friends.add(updFriend);

    await prefs.setStringList(_friendsKey, _friends.map((e) => jsonEncode(e.toJson())).toList());
  }

  Future<void> deleteFriend(Friend dltFriend) async {
    var prefs = await SharedPreferences.getInstance();

    _friends.removeWhere((e) => e.id == dltFriend.id);

    await prefs.setStringList(_friendsKey, _friends.map((e) => jsonEncode(e.toJson())).toList());
  }
}

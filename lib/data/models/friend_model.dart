import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'friend_model.g.dart';

@JsonSerializable()
class Friend extends Equatable {
  final String id;
  final String name;
  final DateTime birthday;

  const Friend({
    required this.name,
    required this.birthday,
    required this.id,
  });

  @override
  List<Object?> get props => [id, name, birthday];

  Friend copyWith({
    String? name,
    DateTime? birthday,
  }) {
    return Friend(
      id: id,
      name: name ?? this.name,
      birthday: birthday ?? this.birthday,
    );
  }

  @override
  String toString() {
    return "$name - $id";
  }

  factory Friend.fromJson(Map<String, dynamic> json) => _$FriendFromJson(json);

  Map<String, dynamic> toJson() => _$FriendToJson(this);
}

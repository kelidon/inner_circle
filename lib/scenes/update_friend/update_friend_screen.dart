import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inner_circle/blocs/friends/friends_cubit.dart';
import 'package:inner_circle/scenes/update_friend/widgets/avatar_widget.dart';
import 'package:uuid/uuid.dart';

import '../../common/app_colors.dart';
import '../../common/widgets/date_text_form_field.dart';
import '../../common/widgets/ic_appbar_title.dart';
import '../../data/models/friend_model.dart';

class UpdateFriendScreen extends StatefulWidget {
  const UpdateFriendScreen({super.key, this.friend});

  final Friend? friend;

  @override
  State<UpdateFriendScreen> createState() => _UpdateFriendScreenState();
}

class _UpdateFriendScreenState extends State<UpdateFriendScreen> {
  String? name;
  DateTime? birthDate;

  @override
  void initState() {
    super.initState();
    name = widget.friend?.name;
    birthDate = widget.friend?.birthday;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const ICAppBarTitle(),
          backgroundColor: Colors.black,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AvatarWidget(
                      size: 126,
                      date: birthDate?.day,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'name',
                  ),
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                ),
                const SizedBox(height: 24),
                DateTextFormField(
                  firstDate: DateTime(1937),
                  lastDate: DateTime.now(),
                  initialDate: birthDate,
                  fieldLabelText: 'birthday',
                  onDateChanged: (date) {
                    setState(() {
                      birthDate = date;
                    });
                  },
                ),
                const SizedBox(height: 24),
                BlocConsumer<FriendsCubit, FriendsState>(
                  listener: (context, state) {
                    if (state is DataState) {
                      Navigator.of(context).pop();
                    }
                  },
                  builder: (context, state) {
                    final bool isProcessing = state is LoadingState;
                    return Row(
                      mainAxisAlignment: widget.friend != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        if (widget.friend != null)
                          FilledButton(
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(AppColors.red)),
                            onPressed: isProcessing
                                ? null
                                : () {
                                    context.read<FriendsCubit>().removeFriend(widget.friend!);
                                  },
                            child: isProcessing
                                ? Center(
                                    child: SizedBox(
                                        width: 30,
                                        child: LinearProgressIndicator(
                                          color: Colors.black,
                                          backgroundColor: Colors.white.withOpacity(0.6),
                                          borderRadius: const BorderRadius.all(Radius.circular(8)),
                                        )))
                                : const Text("remove"),
                          ),
                        FilledButton(
                          onPressed: isProcessing || name == null || birthDate == null
                              ? null
                              : () {
                                  if (widget.friend != null) {
                                    context.read<FriendsCubit>().editFriend(
                                        widget.friend!.copyWith(name: name, birthday: birthDate!));
                                  } else {
                                    context.read<FriendsCubit>().addFriend(Friend(
                                        id: const Uuid().v4(), name: name!, birthday: birthDate!));
                                  }
                                },
                          child: isProcessing
                              ? Center(
                                  child: SizedBox(
                                      width: 30,
                                      child: LinearProgressIndicator(
                                        color: Colors.black,
                                        backgroundColor: Colors.white.withOpacity(0.6),
                                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                                      )))
                              : Text(widget.friend == null ? "keep" : "save"),
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

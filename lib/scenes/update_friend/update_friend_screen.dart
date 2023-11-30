import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inner_circle/blocs/friends/friends_cubit.dart';
import 'package:inner_circle/scenes/update_friend/widgets/avatar_widget.dart';
import 'package:uuid/uuid.dart';

import '../../common/app_colors.dart';
import '../../common/widgets/date_text_form_field.dart';
import '../../data/models/friend_model.dart';

class UpdateFriendScreen extends StatefulWidget {
  const UpdateFriendScreen({super.key, this.friend});

  final Friend? friend;

  @override
  State<UpdateFriendScreen> createState() => _UpdateFriendScreenState();
}

class _UpdateFriendScreenState extends State<UpdateFriendScreen> {
  late final TextEditingController nameController;
  DateTime? birthDate;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.friend?.name);
    birthDate = widget.friend?.birthday;
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    AvatarWidget(
                      size: 126,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'name',
                    )),
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
                const SizedBox(height: 40),
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
                                          borderRadius: BorderRadius.all(Radius.circular(8)),
                                        )))
                                : Text("remove"),
                          ),
                        FilledButton(
                          onPressed: isProcessing
                              ? null
                              : () {
                                  if (widget.friend != null) {
                                    context.read<FriendsCubit>().editFriend(widget.friend!
                                        .copyWith(name: nameController.text, birthday: birthDate!));
                                  } else {
                                    context.read<FriendsCubit>().addFriend(Friend(
                                        id: const Uuid().v4(),
                                        name: nameController.text,
                                        birthday: birthDate!));
                                  }
                                },
                          child: isProcessing
                              ? Center(
                                  child: SizedBox(
                                      width: 30,
                                      child: LinearProgressIndicator(
                                        color: Colors.black,
                                        backgroundColor: Colors.white.withOpacity(0.6),
                                        borderRadius: BorderRadius.all(Radius.circular(8)),
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

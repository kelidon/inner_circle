import 'package:flutter/material.dart';

class AvatarWidget extends StatelessWidget {
  const AvatarWidget({super.key, this.size = 42, this.date});

  final double size;
  final int? date;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.black,
        shape: BoxShape.circle,
        //border: Border.all(color: Colors.white, width: 0.1),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.7),
            spreadRadius: 0.16,
            blurRadius: 1,
            offset: Offset(-size / 125, size / 125),
          ),
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
            spreadRadius: size / 25,
            blurRadius: size / 18,
            offset: Offset(-size / 125, size / 125),
          ),
        ],
      ),
      child: date == null
          ? null
          : Center(
              child: Text(
              date.toString(),
              style: TextStyle(fontSize: size / 2.2),
            )),
    );
  }
}

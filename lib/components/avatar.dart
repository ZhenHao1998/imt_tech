import 'package:flutter/material.dart';
import 'package:imt_tech/model/user.dart';

class Avatar extends StatelessWidget {
  final User user;
  final double? radius;

  const Avatar({
    super.key,
    required this.user,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius ?? 40,
      backgroundImage: NetworkImage(
        user.image,
        scale: 20,
      ),
    );
  }
}

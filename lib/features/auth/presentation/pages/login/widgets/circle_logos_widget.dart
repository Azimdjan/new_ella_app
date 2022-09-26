import 'package:flutter/material.dart';

class CircleLogosWidget extends StatelessWidget {
  final IconData iconName;
  final VoidCallback onTap;

  const CircleLogosWidget({
    Key? key,
    required this.iconName,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 52,
        width: 52,
        decoration: BoxDecoration(
          color: Theme.of(context).disabledColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: Theme.of(context).primaryColor,
            width: 1,
          ),
        ),
        child: Icon(
          iconName,
          size: 30,
        ),
      ),
    );
  }
}

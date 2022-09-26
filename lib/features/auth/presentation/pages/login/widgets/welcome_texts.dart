import 'package:flutter/material.dart';

class WelcomeText extends StatelessWidget {
  final String title;
  final String subtitle;

  const WelcomeText({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headline1,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

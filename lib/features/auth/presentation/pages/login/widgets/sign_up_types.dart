import 'package:flutter/material.dart';

import 'circle_logos_widget.dart';

class SignUpTypes extends StatelessWidget {
  final VoidCallback emailOnTap;

  const SignUpTypes({Key? key, required this.emailOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 46,
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Theme.of(context).primaryColor],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Text(
                "Or Sign Up with",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            Expanded(
              child: Container(
                height: 3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Theme.of(context).primaryColor],
                    end: Alignment.centerLeft,
                    begin: Alignment.centerRight,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleLogosWidget(
              iconName: Icons.facebook,
              onTap: () {},
            ),
            const SizedBox(
              width: 16,
            ),
            CircleLogosWidget(
              iconName: Icons.apple,
              onTap: () {},
            ),
            const SizedBox(
              width: 16,
            ),
            CircleLogosWidget(
              iconName: Icons.alternate_email,
              onTap: emailOnTap,
            ),
          ],
        ),
      ],
    );
  }
}

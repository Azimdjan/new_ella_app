import 'package:ella/core/app_bloc/app_bloc.dart';
import 'package:ella/core/theme/app_theme.dart';
import 'package:ella/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'circle_logos_widget.dart';

class SignUpTypes extends StatelessWidget {
  final VoidCallback emailOnTap;

  const SignUpTypes({Key? key, required this.emailOnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
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
                localization.orSignUpWith,
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
              onTap: () {
                context.read<AppBloc>().add(
                      AppThemeSwitchLight(
                        lightTheme: lightThemes[LightThemes.violetTheme]!,
                      ),
                    );
              },
            ),
            const SizedBox(
              width: 16,
            ),
            CircleLogosWidget(
              iconName: Icons.apple,
              onTap: () {
                context.read<AppBloc>().add(
                      AppThemeSwitchDark(
                        darkTheme: darkThemes[DarkThemes.violetTheme]!,
                      ),
                    );
              },
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

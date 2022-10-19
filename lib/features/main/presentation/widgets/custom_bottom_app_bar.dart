import 'package:ella/features/advices/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:ella/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomBottomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomBottomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalization.of(context);
    return BlocBuilder<CategoryListBloc, CategoryListState>(
      buildWhen: (oldState, currentState) =>
          oldState.runtimeType != currentState.runtimeType,
      builder: (context, state) {
        return Container(
          height: 58,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 12,
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CategoryListBloc>().add(
                          const CategoryListTopButtonTapped(
                            showSavedAdvices: false,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: (state is CategoryListAdvices)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    foregroundColor: (state is CategoryListAdvices)
                        ? Colors.white
                        : Colors.black,
                    elevation: 0,
                  ),
                  child: Text(localization.advices),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    context.read<CategoryListBloc>().add(
                          const CategoryListTopButtonTapped(
                            showSavedAdvices: true,
                          ),
                        );
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: (state is CategoryListSavedAdvices)
                        ? Theme.of(context).primaryColor
                        : Theme.of(context).scaffoldBackgroundColor,
                    foregroundColor: (state is CategoryListSavedAdvices)
                        ? Colors.white
                        : Colors.black,
                  ),
                  child: Text(localization.saved),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(58);
}

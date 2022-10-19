import 'package:ella/features/advices/presentation/bloc/article/article_bloc.dart';
import 'package:ella/features/advices/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:ella/features/advices/presentation/bloc/guid/guid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../constants/constants.dart';
import '../../../../../injector_container.dart';
import '../../../../main/presentation/widgets/custom_bottom_app_bar.dart';
import 'widgets/category_list_advice_body.dart';
import 'widgets/category_list_saved_advice_body.dart';

class CategoryListPage extends StatelessWidget {
  const CategoryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<CategoryListBloc>()
            ..add(
              const CategoryListTopButtonTapped(
                showSavedAdvices: false,
              ),
            ),
        ),
        BlocProvider(create: (_) => sl<GuidBloc>()),
        BlocProvider(create: (_) => sl<ArticleBloc>()),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text('CategoryListPage'),
          elevation: 0,
          bottom: const CustomBottomAppBar(),
        ),
        body: const _CategoryListPageBody(),
      ),
    );
  }
}

class _CategoryListPageBody extends StatelessWidget {
  const _CategoryListPageBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CategoryListBloc, CategoryListState>(
      listener: (context, state) {
        if (state is CategoryListAdvices && state.status.isError()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorMessage ?? Validations.SOMETHING_WENT_WRONG,
              ),
              backgroundColor: Theme.of(context).errorColor,
              shape: ShapeBorder.lerp(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                0,
              ),
              dismissDirection: DismissDirection.horizontal,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is CategoryListAdvices) {
          return CategoryListAdviceBody(
            state: state,
          );
        } else if (state is CategoryListSavedAdvices) {
          return CategoryListSavedAdviceBody(
            state: state,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}

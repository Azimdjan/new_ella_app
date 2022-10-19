import 'package:ella/core/page_arguments/guid_page_params.dart';
import 'package:ella/features/advices/presentation/bloc/category_list/category_list_bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../../router/name_routes.dart';
import 'advice_card.dart';

class CategoryListAdviceBody extends StatelessWidget {
  final CategoryListAdvices state;

  const CategoryListAdviceBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state.status.isEmpty()) {
      return Center(
        child: Image.network(
          "https://down-yuantu.pngtree.com/original_origin_pic/20/04/01/cd117f2638910c9116371132a8ae340a.png?e=1665859735&st=MmY5MTlkZTMyMjFkZjk0YTcwMGQ4Y2I0MTdjNWZlZTE&n=%E2%80%94Pngtree%E2%80%94not+found_5408094.png",
        ),
      );
    } else {
      return ModalProgressHUD(
        inAsyncCall: state.status.isLoading(),
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 12,
                top: 12,
                bottom: 12,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.categoryListEntity?.data?[index].name ?? '',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 210,
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, innerIndex) =>
                              AdviceCardWidget(
                            imageUrl:
                                'https://cdn.jpegmini.com/user/images/slider_puffin_before_mobile.jpg',
                            title: state.categoryListEntity?.data?[index]
                                    .guides?[innerIndex].name ??
                                'Empty',
                            onTap: () {
                              context.pushNamed(
                                Routes.guide,
                                extra: GuidPageParams(
                                    id: state.categoryListEntity?.data?[index]
                                            .guides?[innerIndex].id ??
                                        0,
                                    title: state
                                            .categoryListEntity
                                            ?.data?[index]
                                            .guides?[innerIndex]
                                            .name ??
                                        '',
                                    image:
                                        'https://cdn.jpegmini.com/user/images/slider_puffin_before_mobile.jpg'),
                              );
                            },
                          ),
                          separatorBuilder: (context, _) => const SizedBox(
                            width: 8,
                          ),
                          itemCount: state.categoryListEntity?.data?[index]
                                  .guides?.length ??
                              0,
                        ),
                      ),
                    ],
                  ),
                  childCount: state.categoryListEntity?.data?.length,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}

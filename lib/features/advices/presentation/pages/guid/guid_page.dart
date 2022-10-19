import 'package:ella/core/mixins/sliver_mixin.dart';
import 'package:ella/core/page_arguments/article_page_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../constants/constants.dart';
import '../../../../../core/page_arguments/guid_page_params.dart';
import '../../../../../injector_container.dart';
import '../../../../../router/name_routes.dart';
import '../../bloc/guid/guid_bloc.dart';
import 'widgets/guid_article.dart';
import 'widgets/guid_page_sliver_app_bar.dart';

class GuidPage extends StatefulWidget {
  final GuidPageParams params;

  const GuidPage({Key? key, required this.params}) : super(key: key);

  @override
  State<GuidPage> createState() => _GuidPageState();
}

class _GuidPageState extends State<GuidPage> with SliverMixin<GuidPage> {
  @override
  Widget build(BuildContext context) {
    final params = widget.params;
    return BlocProvider(
      create: (context) => sl<GuidBloc>()..add(GuidLoad(widget.params.id)),
      child: Scaffold(
        body: GuidPageBody(
          scrollController: scrollController,
          isTitleVisible: isTitleVisible,
          errorImage: params.image,
          title: params.title,
          id: widget.params.id,
          params: widget.params,
        ),
      ),
    );
  }
}

class GuidPageBody extends StatelessWidget {
  const GuidPageBody({
    Key? key,
    required this.scrollController,
    required this.isTitleVisible,
    required this.title,
    required this.errorImage,
    required this.id,
    required this.params,
  }) : super(key: key);

  final ScrollController scrollController;
  final bool isTitleVisible;
  final String title;
  final String errorImage;
  final GuidPageParams params;
  final num id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GuidBloc, GuidState>(
      listener: (context, state) {
        if (state.status.isError) {
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
        return CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: scrollController,
          slivers: [
            GuidPageSliverAppBar(
              isTitleVisible: isTitleVisible,
              title: title,
              imageUrl:
                  "https://img.freepik.com/premium-photo/newborn-toddler-boy-laughing-bed_115594-1502.jpg?w=2000",
              errorImage: errorImage,
              id: id,
              isSaved: state.isSaved,
            ),
            CupertinoSliverRefreshControl(
              onRefresh: () async {
                await Future.delayed(const Duration(seconds: 1));
                context.read<GuidBloc>().add(GuidRefresh(id));
              },
              refreshTriggerPullDistance: 50,
              refreshIndicatorExtent: 50,
            ),
            SliverToBoxAdapter(
              child: state.status.isLoading
                  ? const SizedBox(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        color: Theme.of(context).backgroundColor,
                      ),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        itemBuilder: (context, index) => GuidArticleWidget(
                          imageUrl:
                              'https://i.pinimg.com/736x/98/04/6d/98046db7ebd80203b56b706440dd96db.jpg',
                          title: state.guidList?.data?.articles?[index].title ??
                              '',
                          subtitle: 'Краткая информация для вас',
                          onTap: () {
                            context.pushNamed(
                              Routes.article,
                              extra: ArticlePageParams(
                                id: state.guidList?.data?.articles?[index].id ??
                                    0,
                                title: state.guidList?.data?.articles?[index]
                                        .title ??
                                    '',
                              ),
                            );
                          },
                        ),
                        separatorBuilder: (context, _) =>
                            const SizedBox(height: 12),
                        itemCount: state.guidList?.data?.articles?.length ?? 0,
                      ),
                    ),
            )
          ],
        );
      },
    );
  }
}

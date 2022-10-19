import 'package:cached_network_image/cached_network_image.dart';
import 'package:ella/features/advices/presentation/bloc/guid/guid_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class GuidPageSliverAppBar extends StatelessWidget {
  const GuidPageSliverAppBar({
    Key? key,
    required this.isTitleVisible,
    required this.imageUrl,
    required this.errorImage,
    required this.title,
    required this.isSaved,
    required this.id,
  }) : super(key: key);

  final bool isTitleVisible;
  final String imageUrl;
  final String errorImage;
  final String title;
  final bool isSaved;
  final num id;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 260,
      collapsedHeight: 56,
      pinned: true,
      automaticallyImplyLeading: false,
      title: isTitleVisible
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.headline5,
                ),
                IconButton(
                  onPressed: () {
                    context.read<GuidBloc>().add(GuidSave(id));
                  },
                  icon: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                ),
              ],
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.fadeTitle,
          StretchMode.blurBackground,
        ],
        titlePadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        centerTitle: false,
        collapseMode: CollapseMode.parallax,
        background: Stack(
          children: [
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl:
                    'https://img.freepik.com/premium-photo/newborn-toddler-boy-laughing-bed_115594-1502.jpg?w=2000',
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => Image.network(
                  errorImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF000000).withOpacity(0),
                      const Color(0xFF000000).withOpacity(0.6),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 44,
              left: 16,
              child: GestureDetector(
                onTap: () => context.pop(),
                child: Container(
                  height: 40,
                  width: 40,
                  alignment: const Alignment(0.3, 0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 44,
              right: 16,
              child: GestureDetector(
                onTap: () {
                  context.read<GuidBloc>().add(GuidSave(id));
                },
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 7,
                        offset:
                            const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_border_sharp,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        title: !isTitleVisible
            ? Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      color: Colors.white,
                    ),
              )
            : null,
      ),
    );
  }
}

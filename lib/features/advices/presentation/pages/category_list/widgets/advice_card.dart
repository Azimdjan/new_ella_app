import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AdviceCardWidget extends StatelessWidget {
  final String imageUrl;
  final String title;
  final VoidCallback onTap;

  const AdviceCardWidget({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 144,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, value) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                },
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF000000).withOpacity(0),
                    const Color(0xFF000000).withOpacity(0.8),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            right: 12,
            child: Text(
              title,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.headline5?.copyWith(
                    color: Colors.white,
                  ),
            ),
          ),
          Positioned.fill(
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onTap,
                  overlayColor: MaterialStateColor.resolveWith(
                    (states) =>
                        Theme.of(context).primaryColor.withOpacity(0.05),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

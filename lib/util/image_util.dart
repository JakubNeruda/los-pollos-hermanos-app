import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

Widget buildImage(
  String url, {
  fit = BoxFit.scaleDown,
  cacheDuration = const Duration(hours: 1),
}) {
  return CachedNetworkImage(
    imageUrl: url,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageProvider,
          fit: fit,
        ),
      ),
    ),
    cacheManager: CacheManager(
      Config('cacheKey', stalePeriod: cacheDuration),
    ),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}

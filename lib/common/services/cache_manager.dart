import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart'; 

class AppCacheManager {
  static const String _cacheKey = 'beauty';
  final _cacheManager = CacheManager(Config(
    _cacheKey,
    stalePeriod: const Duration(days: 30),
  ));

  AppCacheManager();

  Future<void> precache(BuildContext context, String url) {
    return precacheImage(getImage(url), context);
  }

  ImageProvider<CachedNetworkImageProvider> getImage(String url) {
    return CachedNetworkImageProvider(url, cacheManager: _cacheManager);
  }
 
}

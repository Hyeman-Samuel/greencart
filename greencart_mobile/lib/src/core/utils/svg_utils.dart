import 'package:flutter_svg/flutter_svg.dart';

class SvgUtils {
  static List<String> onboardingSvgs = [];

  static Future<void> preCacheSVGs(List<String> svgPaths) async {
    for (final path in svgPaths) {
      final loadSvg = SvgAssetLoader(path);
      await svg.cache.putIfAbsent(
        loadSvg.cacheKey(null),
        () => loadSvg.loadBytes(null),
      );
    }
  }
}

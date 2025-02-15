import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

abstract class Shimmer extends StatelessWidget {
  const Shimmer._({super.key});
  const factory Shimmer({
    Key? key,
    required Widget child,
    PaintingEffect? effect,
  }) = _SkeletonShimmer;

  const factory Shimmer.zone({
    Key? key,
    required Widget child,
    PaintingEffect? effect,
  }) = _SkeletonShimmer.zone;
}

class _SkeletonShimmer extends Shimmer {
  final Widget child;
  final PaintingEffect? effect;
  final bool _isZoned;

  const _SkeletonShimmer({super.key, required this.child, this.effect})
    : _isZoned = false,
      super._();

  const _SkeletonShimmer.zone({super.key, required this.child, this.effect})
    : _isZoned = true,
      super._();

  @override
  Widget build(BuildContext context) {
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        effect: ShimmerEffect(
          // baseColor: context.kamonaTheme.ui.skeleton.variant,
          // highlightColor: context.kamonaTheme.ui.skeleton.defaults,
        ),
      ),
      child:
          _isZoned
              ? Skeletonizer.zone(
                ignorePointers: true,
                effect: effect,
                child: child,
              )
              : Skeletonizer(
                ignorePointers: true,
                effect: effect,
                child: child,
              ),
    );
  }
}

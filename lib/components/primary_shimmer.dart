import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PrimaryShimmer extends StatelessWidget {
  final bool showShimmer, wrapWithBackground;
  final double? circularRadius;
  final Widget child;

  const PrimaryShimmer({
    Key? key,
    required this.child,
    this.circularRadius,
    this.showShimmer = false,
    this.wrapWithBackground = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (showShimmer) {
      return AbsorbPointer(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade100,
          highlightColor: Colors.grey.shade50,
          period: const Duration(milliseconds: 900),
          child: wrapWithBackground
              ? Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(circularRadius ?? 8.0),
                    color: Colors.white,
                  ),
                  child: child,
                )
              : child,
        ),
      );
    }

    return child;
  }
}

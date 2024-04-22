import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RidesShimmer extends StatelessWidget {
  const RidesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.toHeight,
          vertical: 16.toWidth,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 150.toHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              15.emptyHeight,
              Container(
                width: double.infinity,
                height: 150.toHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              15.emptyHeight,
              Container(
                width: double.infinity,
                height: 150.toHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              15.emptyHeight,
              Container(
                width: double.infinity,
                height: 150.toHeight,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

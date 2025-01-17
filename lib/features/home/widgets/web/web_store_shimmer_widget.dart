import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/common/widgets/rating_bar.dart';

class WebStoreShimmerWidget extends StatelessWidget {
  const WebStoreShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: 500,
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)]
      ),
      child: Shimmer(
    period: const Duration(seconds: 2),
          enabled: true,
          gradient: LinearGradient(
            colors: [
              Colors.grey.withOpacity(0.1), // First color with 10% opacity
              Colors.grey.withOpacity(0.2), // Second color with 20% opacity
              Colors.grey.withOpacity(0.1), // Third color with 10% opacity
            ],
            stops: [0.1, 0.5, 0.9],  // Positions of the gradient colors
            begin: Alignment(-1.0, -0.3),
            end: Alignment(1.0, 0.3),
          ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [

          Container(
            height: 120, width: 500,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusSmall)),
                color: Colors.grey[300]
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeExtraSmall),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(height: 15, width: 100, color: Colors.grey[300]),
                const SizedBox(height: 5),

                Container(height: 10, width: 130, color: Colors.grey[300]),
                const SizedBox(height: 5),

                const RatingBar(rating: 0.0, size: 12, ratingCount: 0),
              ]),
            ),
          ),

        ]),
      ),
    );
  }
}
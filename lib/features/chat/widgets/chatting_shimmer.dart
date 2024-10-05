import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'package:sixam_mart/util/dimensions.dart';

class ChattingShimmer extends StatelessWidget {
  const ChattingShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
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
      child: SizedBox(
        height: Get.height * 0.80,
        child: SingleChildScrollView(
          child: Column(children:[

            Container(margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              height: 65,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [

                Container(height: 50, width: 50,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(100))),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Container(height: 40, width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault)),
                  ),
                ),

              ]),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              height: 50,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [

                Container(height: 40, width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomLeft: Radius.circular(Dimensions.radiusDefault)
                    )
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(100))),
                ),

              ],),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [

                Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Container(
                  height: 80,
                  width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault),
                    ),
                  ),
                ),

              ]),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.end, children: [

                Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(100)),),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Container(height: 120, width: 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault),bottomLeft: Radius.circular(Dimensions.radiusDefault)),
                  ),),

              ])
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              height: 65,
              child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [

                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomLeft: Radius.circular(Dimensions.radiusDefault)),
                  ),),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(color: Colors.grey[300],
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                  ),
                ),

              ]),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [

                Container(height: 80, width: 250,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomLeft: Radius.circular(Dimensions.radiusDefault))
                  ),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(color: Colors.grey[300],  borderRadius: const BorderRadius.all(Radius.circular(100))),
                ),

              ]),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              height: 50,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [

                Container(
                  height: 50, width: 50,
                  decoration: BoxDecoration(color: Colors.grey[300],  borderRadius: const BorderRadius.all(Radius.circular(100))),
                ),
                const SizedBox(width: Dimensions.paddingSizeDefault),

                Container(
                  height: 40,
                  width: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault)),
                  ),
                ),

              ]),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(color: Colors.grey[300],  borderRadius: const BorderRadius.all(Radius.circular(100))),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  Container(
                    height: 40,
                    width: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault)),
                    ),
                  ),

                ],
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: const BorderRadius.only(topRight: Radius.circular(Dimensions.radiusDefault),topLeft: Radius.circular(Dimensions.radiusDefault), bottomRight: Radius.circular(Dimensions.radiusDefault),bottomLeft: Radius.circular(Dimensions.radiusDefault)),
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeDefault),

                  Container(
                    height: 50, width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[300], borderRadius: const BorderRadius.all(Radius.circular(100)),
                    ),
                  ),

                ],
              ),
            ),

          ]),
        ),
      ),
    );
  }
}